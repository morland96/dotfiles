return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      require("plugins.ai.utils.notification").init()
      require("plugins.ai.utils.extmarks").setup()
    end,
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion Chat", mode = { "n", "v" } },
      { "<leader>a.", "<cmd>CodeCompanionActions<cr>", desc = "Toggle CodeCompanion Actions", mode = { "n", "v" } },
      {
        "<leader>ai",
        ":CodeCompanion<cr>",
        desc = "Toggle CodeCompanion Inline",
        mode = { "n", "v" },
      },
    },
    interactions = {
      chat = {
        adapter = "copilot",
        model = "claude-sonnet-4.5",
      },
      cmd = {
        adapter = "copilot",
        model = "claude-sonnet-4.5",
      },
      inline = {
        adapter = "copilot",
        model = "claude-sonnet-4.5",
        keymaps = {
          stop = {
            modes = { n = "q" },
            index = 4,
            callback = "keymaps.stop",
            description = "Stop request",
          },
        },
      },
    },
    opts = {
      prompt_library = {
        markdown = {
          dirs = {
            "~/dotfiles/nvim/lua/plugins/ai/prompts",
          },
        },
      },
      adapters = {
        acp = {
          rovodev = function()
            local helpers = require("codecompanion.adapters.acp.helpers")
            return {
              name = "rovodev",
              type = "acp",
              formatted_name = "RovoDev",
              roles = {
                llm = "assistant",
                user = "user",
              },
              opts = {
                verbose_output = true,
              },
              commands = {
                default = {
                  "acli",
                  "rovodev",
                  "acp",
                },
              },
              defaults = {},
              parameters = {
                protocolVersion = 1,
                clientCapabilities = {
                  fs = { readTextFile = true, writeTextFile = true },
                },
                clientInfo = {
                  name = "CodeCompanion.nvim",
                  version = "1.0.0",
                },
              },
              handlers = {
                setup = function(self)
                  return true
                end,
                form_messages = function(self, messages, capabilities)
                  return helpers.form_messages(self, messages, capabilities)
                end,
                on_exit = function(self, code) end,
              },
            }
          end,
        },
      },
      -- strategies = {
      --   chat = {
      --     adapter = "rovodev",
      --   },
      --   inline = {
      --     adapter = "copilot",
      --   },
      --   cmd = {
      --     adapter = "rovodev",
      --     model = "claude-sonnet-4.5",
      --   },
      -- },
      opts = {
        log_level = "DEBUG",
      },
    },
  },
}
