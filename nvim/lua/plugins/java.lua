return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = { "java" },
    opts = function()
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
                    path = "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home",
                  },
                },
              },
            },
          },
        },

        -- How to run jdtls. This can be overridden to a full java command-line
        -- if the Python wrapper script doesn't suffice.
        -- Using $JAVA_17_HOME
        cmd = { "jdtls", "-Xmx4g" },
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
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
