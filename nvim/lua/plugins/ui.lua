return {
  -- Change the window picker's behavior to use floating windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      event = "VeryLazy",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          hint = "floating-big-letter",
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },
  -- File Browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_extend("force", opts.defaults, {
        path_display = { "smart" },
        layout_config = {
          width = 0.95,
          prompt_position = "top",
          preview_cutoff = 120,
        },
        color_devicons = true,
        sorting_strategy = "ascending",
        winblend = 0,
        prompt_prefix = "   ",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      })

      opts.extensions_list = { "themes", "terms", "fzf" }

      opts.pickers = {
        lsp_references = { fname_width = 55, show_line = true },
      }
    end,
  },
  -- Bookmarks
  {
    "MattesGroeger/vim-bookmarks",
    -- event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
    },
    init = function()
      vim.g.bookmark_no_default_key_mappings = 1
    end,
    config = function()
      require("telescope").load_extension("vim_bookmarks")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 40,
        },
        global_settings = {
          save_on_toggle = false,
          save_on_change = true,
        },
      })
      require("telescope").load_extension("harpoon")
      vim.cmd("autocmd FileType harpoon setlocal wrap")
    end,
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        delay = 50,
        animation = function(s, n)
          return 10
        end,
      },
    },
  },
  -- Noice
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = true,
        },
      },
      presets = {
        lsp_doc_border = true,
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      views = {
        mini = {
          timeout = 1000,
          size = { width = "auto", height = "5%"},
        },
      }
    },
  },
  -- Kitty integration
  {
    "knubie/vim-kitty-navigator",
  },
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options = {
        theme = "catppuccin",
      }
    end,
  }
}
