return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = { "java" },
    opts = function()
      local root_dir = require("jdtls.setup").find_root({ ".git" })
      local project_name = root_dir and vim.fs.basename(root_dir)
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
      local home = os.getenv("HOME")
      local jdtls_base = home .. "/.local/share/nvim/mason/packages/jdtls"
      return {
        -- How to find the root dir for a given filename. The default comes from
        -- lspconfig which provides a function specifically for java projects.
        root_dir = function(fname)
          return require("jdtls.setup").find_root({ ".git" })
        end,

        -- How to find the project name for a given root dir.
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,
        jdtls = {
          settings = {
            java = {
              format = {
                settings = {
                  url = "~/.config/style/eclipse-java-google-style.xml",
                },
              },
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-11",
                    path = "/Users/mmeng/.asdf/installs/java/temurin-11.0.21+9",
                  },
                },
              },
            },
          },
        },

        -- How to run jdtls. This can be overridden to a full java command-line
        -- if the Python wrapper script doesn't suffice.
        -- Using $JAVA_17_HOME
        cmd = {
          "/Users/mmeng/.asdf/installs/java/temurin-17.0.9+9/bin/java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.glob(jdtls_base .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
          "-configuration",
          jdtls_base .. "/config_mac_arm",
          "-data",
          workspace_dir,
        },
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          return cmd
        end,

        -- These depend on nvim-dap, but can additionally be disabled by setting false here.
        dap = { hotcodereplace = "auto", config_overrides = {} },
        test = true,
      }
    end,
  },
  {
    "google/vim-codefmt",
    dependencies = { "google/vim-maktaba", "google/vim-glaive" },
    config = function()
      vim.cmd("call glaive#Install()")
      -- Java FileType
      vim.cmd([[
        Glaive codefmt google_java_executable="java -jar /Users/mmeng/.config/style/google-java-format-1.18.0-all-deps.jar"
        autocmd FileType java AutoFormatBuffer google-java-format
      ]])
    end,
  },
}
