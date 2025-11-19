if vim.g.vscode then
  return {}
else
  return {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      -- Temp fix until https://github.com/LazyVim/LazyVim/pull/6354 fixed
      -- opts = function(_, opts)
      --   local module = require("catppuccin.groups.integrations.bufferline")
      --   if module then
      --     module.get = module.get_theme
      --   end
      --   return opts
      -- end,
      config = function()
        require("catppuccin").setup({
          integrations = {
            -- cmp = true,
            gitsigns = true,
            -- nvimtree = true,
            -- treesitter = true,
            notify = true,
            mini = {
              enabled = true,
              indentscope_color = "",
            },
            which_key = true,
            harpoon = true,
            treesitter_context = true,
            telescope = {
              enabled = true,
              style = "nvchad",
            },
            blink_cmp = true,
            snacks = {
              enabled = true,
            },
          },
          float = {
            -- transparency if using neovideo
            -- transparent = vim.g.neovide and true or false,
            transparent = true,
            solid = false, -- use solid styling for floating windows, see |winborder|
          },
        })
      end,
    },
    {
      "folke/tokyonight.nvim",
      lazy = true,
      opts = {},
      vscode = true,
    },
    { "olimorris/onedarkpro.nvim", priority = 1000, vscode = true },
    -- { "navarasu/onedark.nvim" },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "catppuccin-macchiato",
      },
      vscode = true,
    },
  }
end
