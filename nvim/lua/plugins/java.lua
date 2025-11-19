local config = require("lazyvim.config")
return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = { "java" },
    opts = function()
      local root_dir = require("jdtls.setup").find_root({ ".git", "pipelines-config.json" })
      local project_name = root_dir and vim.fs.basename(root_dir)
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
      local home = os.getenv("HOME")
      local jdtls_base = home .. "/.local/share/nvim/mason/packages/jdtls"
      local wk = require("which-key")
      local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
      return {
        -- How to find the root dir for a given filename. The default comes from
        -- lspconfig which provides a function specifically for java projects.
        root_dir = function(fname)
          return require("jdtls.setup").find_root({ "pipelines-config.json", ".git" })
        end,

        -- How to find the project name for a given root dir.
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_namem)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,
        jdtls = {
          settings = {
            java = {
              symbols = {
                includeSourceMethodDeclarations = true,
              },
              eclipse = { downloadSources = true },
              maven = { downloadSources = true },
              inlayHints = { parameterNames = { enabled = "none" } },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              references = { enabled = true },
              signatureHelp = { enabled = true },
              contentProvider = {preferred = "fernflower"},
              format = {
                settings = {
                  url = "~/.config/style/eclipse-java-google-style.xml",
                },
              },
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-17",
                    path = "/Users/mmeng/.local/share/mise/installs/java/corretto-17.0.10.7.1/bin/java",
                  },
                },
              },
            },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
              },
            },
            extendedClientCapabilities = extendedClientCapabilities,
          },
        },
        flags = {
          allow_incremental_sync = true,
        },
        -- How to run jdtls. This can be overridden to a full java command-line
        -- if the Python wrapper script doesn't suffice.
        -- Using $JAVA_17_HOME
        cmd = {
          "/Users/mmeng/.local/share/mise/installs/java/corretto-21.0.8.9.1/bin/java",
          --"/Users/mmeng/.local/share/mise/installs/java/corretto-17.0.10.7.1/bin/java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ERROR",
          -- Optimized memory settings
          "-Xms2g", -- Increased initial heap
          "-Xmx8g", -- Reduced max heap from 12g to 8g for better GC
          "-XX:+UseG1GC",
          "-XX:+UseStringDeduplication", -- Add string deduplication
          "-XX:G1HeapRegionSize=32m", -- Optimize G1 region size
          "-XX:+DisableExplicitGC", -- Disable explicit GC calls
          "-XX:+UseCompressedOops", -- Use compressed object pointers
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.glob(jdtls_base .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
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
        -- Optimized LSP handlers for better performance
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            update_in_insert = false, -- Don't update diagnostics while typing
            virtual_text = {
              spacing = 4,
              source = "if_many",
              severity = { min = vim.diagnostic.severity.WARN }, -- Only show warnings and errors
            },
            signs = true,
            underline = true,
          }),
        },
        on_attach = function(args)
          wk.add({
            {
              mode = "n",
              buffer = args.buf,
              {},
            },
          })
        end,
      }
    end,
  },
  {
    "google/vim-codefmt",
    lazy = true,
    ft = { "java" },
    dependencies = { "google/vim-maktaba", "google/vim-glaive" },
    config = function()
      vim.cmd("call glaive#Install()")
      -- Java FileType
      vim.cmd([[
        Glaive codefmt google_java_executable="java -jar /Users/mmeng/.config/style/google-java-format-1.28.0-all-deps.jar --skip-reflowing-long-strings"
        autocmd FileType java AutoFormatBuffer google-java-format
      ]])
    end,
  },
}
