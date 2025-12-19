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
      cli = {
        tools = {
          rovodev = { cmd = { "acli", "rovodev" }, is_proc = "\\<acli rovodev\\>" },
        },
      },
    },
  },
}
