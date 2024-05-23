local Config = require("lazyvim.config")
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
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      opts.menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      }
      opts.settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      }
    end,
    keys = function()
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end
      local harpoon = require("harpoon")
      local keys = {
        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon Add",
        },
        {
          "gh",
          function()
            require("harpoon"):list():next()
          end,
        },
        {
          "gl",
          function()
            require("harpoon"):list():prev()
          end,
        },
        {
          "<leader>hl",
          function()
            toggle_telescope(harpoon:list())
          end,
          desc = "Harpoon Add",
        },
        {
          "<leader><enter>",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
  {
    "echasnovski/mini.indentscope",
    event = "LazyFile",
    opts = {
      draw = {
        delay = 50,
        animation = function(s, n)
          return 10
        end,
      },
      try_as_border = true
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
          size = { width = "auto", height = "5%" },
        },
      },
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
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = function(_, opts)
      opts.layouts = {
        {
          elements = {
            { id = "scopes", size = 0.5 },
            -- { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 0.20,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      }
    end,
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close({})
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close({})
      -- end
    end,
  },
  {
    "stevearc/aerial.nvim",
    event = "LazyFile",
    opts = function()
      local icons = vim.deepcopy(Config.icons.kinds)

      -- HACK: fix lua's weird choice for `Package` for control
      -- structures like if/else/for/etc.
      icons.lua = { Package = icons.Control }

      ---@type table<string, string[]>|false
      local filter_kind = false
      if Config.kind_filter then
        filter_kind = assert(vim.deepcopy(Config.kind_filter))
        filter_kind._ = filter_kind.default
        filter_kind.default = nil
      end

      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        layout = {
          resize_to_content = false,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        icons = icons,
        filter_kind = filter_kind,
      -- stylua: ignore
      guides = {
        mid_item   = "├╴",
        last_item  = "└╴",
        nested_top = "│ ",
        whitespace = "  ",
      },
      }
      return opts
    end,
    keys = {
      { "<leader>cS", "<cmd>AerialToggle! right<cr>", desc = "Aerial (Symbols)" },
    },
  },
  {
    "folke/trouble.nvim",
    branch = "dev",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      {
        "gR",
        "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>ue",
        function()
          require("edgy").toggle()
        end,
        desc = "Edgy Toggle",
      },
    -- stylua: ignore
    { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    opts = function()
      local opts = {
        animation = { enabled = false },
        bottom = {
          {
            ft = "toggleterm",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf)
              return not vim.b[buf].lazyterm_cmd
            end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            -- don't open help files in edgy that we're editing
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
          { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
          { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
        },
        -- left = {
        --   {
        --     title = "Neo-Tree",
        --     ft = "neo-tree",
        --     filter = function(buf)
        --       return vim.b[buf].neo_tree_source == "filesystem"
        --     end,
        --     pinned = true,
        --     open = function()
        --       require("neo-tree.command").execute({ dir = LazyVim.root() })
        --     end,
        --     size = { height = 0.5 },
        --   },
        --   { title = "Neotest Summary", ft = "neotest-summary" },
        --   {
        --     title = "Neo-Tree Git",
        --     ft = "neo-tree",
        --     filter = function(buf)
        --       return vim.b[buf].neo_tree_source == "git_status"
        --     end,
        --     pinned = true,
        --     open = "Neotree position=right git_status",
        --   },
        --   {
        --     title = "Neo-Tree Buffers",
        --     ft = "neo-tree",
        --     filter = function(buf)
        --       return vim.b[buf].neo_tree_source == "buffers"
        --     end,
        --     pinned = true,
        --     open = "Neotree position=top buffers",
        --   },
        --   "neo-tree",
        -- },
        keys = {
          -- increase width
          ["<c-Right>"] = function(win)
            win:resize("width", 2)
          end,
          -- decrease width
          ["<c-Left>"] = function(win)
            win:resize("width", -2)
          end,
          -- increase height
          ["<c-Up>"] = function(win)
            win:resize("height", 2)
          end,
          -- decrease height
          ["<c-Down>"] = function(win)
            win:resize("height", -2)
          end,
        },
      }
      return opts
    end,
  },
}
