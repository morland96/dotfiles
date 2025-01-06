-- Code related plugins
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
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
  -- Surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzn",
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
        "rst",
        "toml",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "rust",
        "ron",
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
