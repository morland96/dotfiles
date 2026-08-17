return {
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
    },
  },
  {
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false }, -- Disable the Copilot NES integration
      cli = {
        tools = {
          rovodev = { cmd = { "acli", "rovodev" }, is_proc = "\\<acli rovodev\\>" },
        },
      },
    },
    {
      -- Always disable the Copilot LSP server, as we are not using it.
      "neovim/nvim-lspconfig",
      opts = function(_, opts)
        if opts.servers then
          opts.servers.copilot = nil
        end
      end,
    },
  },
}
