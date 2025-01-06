return {
  {
    "haydenmeade/neotest-jest",
    commit = "959d45b",
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    keys = {
      -- {
      --   "<leader>tl",
      --   function()
      --     require("neotest").run.run_last()
      --   end,
      --   desc = "Run Last Test",
      -- },
      -- {
      --   "<leader>tL",
      --   function()
      --     require("neotest").run.run_last({ strategy = "dap" })
      --   end,
      --   desc = "Debug Last Test",
      -- },
      {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'yarn test -- --watchAll' })<cr>",
        desc = "Run Watch",
      },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "yarn test:ci",
          jestConfigFile = "jest.config.js",
          --env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
    end,
  },
}
