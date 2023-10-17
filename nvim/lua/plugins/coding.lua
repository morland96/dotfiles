-- Code related plugins
return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cS", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  -- override nvim-cmp to use copilot and emoji
  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "zbirenbaum/copilot-cmp",
      "onsails/lspkind.nvim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "copilot" }, { name = "emoji" } }))
      opts.mapping = {
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Down>"] = cmp.mapping.abort(),
        ["<Up>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<C-f>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }
      opts.window = {
        completion = cmp.config.window.bordered({
          col_offset = -3,
          side_padding = 0,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      }

      opts.formatting.fields = { "kind", "abbr", "menu" }
      opts.formatting.format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
        })(entry, vim_item)

        local strings = vim.split(kind.kind, "%s", { trimempty = true })

        if strings[1] ~= "Copilot" then
          kind.kind = " " .. strings[1] .. " "
          kind.menu = "    (" .. strings[2] .. ")"
        else
          kind.kind = " " .. vim.fn.nr2char(0xe708) .. " "
          kind.menu = "    (" .. "copilot" .. ")"
        end

        return kind
      end
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_extend("force", opts.defaults, {
        ["<leader>r"] = { name = "+refactoring" },
        -- ["<leader>d"] = { name = "+debug" },
        -- ["<leader>da"] = { name = "+adapters" },
      })
    end,
  },
  -- Surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "<leader>csa",
        delete = "<leader>csd",
        find = "<leader>csf",
        find_left = "<leader>csF",
        highlight = "<leader>csh",
        replace = "<leader>csr",
        update_n_lines = "<leader>csn",
      },
    },
  },
  -- LSP
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "jdtls@0.57" })
  --   end,
  -- },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true, disable = { "yaml", "python", "java" } },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = { ["<leader>ma"] = "@parameter.inner" },
          swap_previous = { ["<leader>mA"] = "@parameter.inner" },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]a"] = { query = "@parameter.inner", desc = "Next parameter" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]c"] = { query = "@conditional.outer", desc = "Next condition start" },
            ["]o"] = "@loop.*",
            ["]l"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]A"] = { query = "@parameter.inner", desc = "Next parameter" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]O"] = "@loop.*",
            ["]L"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]Z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_previous_start = {
            ["[a"] = { query = "@parameter.inner", desc = "Previous parameter" },
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[c"] = { query = "@conditional.outer", desc = "Previous condition start" },
            ["[o"] = "@loop.*",
            ["[l"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
            ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
          },
          goto_previous_end = {
            ["[A"] = { query = "@parameter.inner", desc = "Previous parameter" },
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[O"] = "@loop.*",
            ["[L"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
            ["[Z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
          },
        },
      },
    },
  },
}
