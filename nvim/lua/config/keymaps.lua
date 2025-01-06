-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby
vim.keymap.del('n', '<leader>p', {})
local map = vim.keymap.set
local nx = { "n", "x" }

  -- groups
  local wk = require("which-key")
  wk.add({
        { "<leader>p", group = "+project" },
        { "<leader>r", group = "+refactoring" },
  })

map("n", "<Leader>wh", "<C-w>h", { desc = "Go to left window" })
map("n", "<Leader>wj", "<C-w>j", { desc = "Go to bottom window" })
map("n", "<Leader>wk", "<C-w>k", { desc = "Go to top window" })
map("n", "<Leader>wl", "<C-w>l", { desc = "Go to right window" })

if vim.g.vscode then
  -- Makes vscode happy
  map("n", "<Space>", "<Cmd>call VSCodeNotify('whichkey.show')<CR>", { silent = true })
  map("x", "<Space>", "<Cmd>call VSCodeNotify('whichkey.show')<CR>", { silent = true })

  -- Better Navigation
  map({ "n", "x" }, "<C-h>", "<Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>")
  map({ "n", "x" }, "<C-j>", "<Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>")
  map({ "n", "x" }, "<C-k>", "<Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>")
  map({ "n", "x" }, "<C-l>", "<Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>")
  -- Project
  map("n", "<Leader>pp", "<Cmd>call VSCodeNotify('workbench.action.files.openFolder')<CR>")
end

if vim.g.vscode then
else
  -- Windows Resize
  map("n", "<C-S-h>", "<C-w><", { desc = "Decrease window width" })
  map("n", "<C-S-j>", "<C-w>-", { desc = "Decrease window height" })
  map("n", "<C-S-k>", "<C-w>+", { desc = "Increase window height" })
  map("n", "<C-S-l>", "<C-w>>", { desc = "Increase window width" })

  -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
  map("n", "<A-h>", require("smart-splits").resize_left)
  map("n", "<A-j>", require("smart-splits").resize_down)
  map("n", "<A-k>", require("smart-splits").resize_up)
  map("n", "<A-l>", require("smart-splits").resize_right)
  -- moving between splits
  map("n", "<C-h>", require("smart-splits").move_cursor_left)
  map("n", "<C-j>", require("smart-splits").move_cursor_down)
  map("n", "<C-k>", require("smart-splits").move_cursor_up)
  map("n", "<C-l>", require("smart-splits").move_cursor_right)
  map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
  -- Kitty
  -- map(nx, "<C-h>", "<cmd>:KittyNavigateLef<cr>")
  -- map(nx, "<C-j>", "<cmd>:KittyNavigateDown<cr>")
  -- map(nx, "<C-k>", "<cmd>:KittyNavigateUp<cr>")
  -- map(nx, "<C-l>", "<cmd>:KittyNavigateRight<cr>")


  -- fzf lua
  --  map("n", "<Leader>pp", "<Leader>fp", { desc = "Find Projects" })
  map("n", "<Leader>pf", LazyVim.pick("files"), { desc = "Find Project Files" })
  map("n", "<Leader>pg", LazyVim.pick("live_grep"), { desc = "Grep Project Files" })

  map("n", "<Leader>bb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Find Buffers" })

  -- Telescope
  local telescope_builtin = require("telescope.builtin")

  map("n", "<Leader>bb", "<Cmd>Telescope buffers<CR>", { desc = "Find Buffers" })

  -- Editor
  map("n", "<D-k>", "<Cmd>m-2<CR>", { desc = "Move line up" })
  map("n", "<D-j>", "<Cmd>m+<CR>", { desc = "Move line down" })

  -- Files
  local format = function()
    require("lazyvim.plugins.lsp.format").format({ force = true })
  end

  map("n", "<Leader>fs", "<Cmd>write<CR>", { desc = "Save File" })
  map("n", "<D-s>", "<Cmd>write<CR>", { desc = "Save File" })

  map(nx, "<M-S-f>", format, { desc = "Format File" })

  -- Jump
  map("n", "<Leader>js", "<cmd>FzfLua treesitter<cr>", { desc = "Jump treesitter" })

  -- Search
  map("n", "<Leader>s.", "<cmd>FzfLua<cr>", { desc = "FzfLua search" })

  -- Goto
  map("n", "<Leader>ci", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Goto Implementation" })

  -- Bookmarks
  local bm = require("telescope").extensions.vim_bookmarks
  -- map(nx, "<Leader><enter>", bm.all, { desc = "List Bookmarks" })
  map(nx, "<Leader>mm", "<Cmd>BookmarkToggle<CR>", { desc = "Toggle Bookmark" })
  map(nx, "<Leader>mi", "<Cmd>BookmarkAnnotate<CR>", { desc = "Bookmark Annotate" })
  map(nx, "<Leader>mn", "<Cmd>BookmarkNext<CR>", { desc = "Next Bookmark" })
  map(nx, "<Leader>mp", "<Cmd>BookmarkPrev<CR>", { desc = "Previous Bookmark" })
  map(nx, "<Leader>ml", bm.all, { desc = "List Bookmarks" })
  map(nx, "<Leader>mc", "<Cmd>BookmarkClear<CR>", { desc = "Clear Bookmarks" })
  map(nx, "<Leader>mx", "<Cmd>BookmarkClearAll<CR>", { desc = "Clear All Bookmarks" })

  -- Refactor
  map("n", "<Leader>rr", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<Leader>ra", vim.lsp.buf.code_action, { desc = "Code Action" })

  -- Java
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local wk = require("which-key")
      wk.add({
        {"<leader>clr", vim.lsp.codelens.refresh, desc = "Refresh CodeLens", buffer = args.buf},
        {"<leader>cla", vim.lsp.codelens.run, desc = "Run CodeLens", buffer = args.buf},
        {"<leader>cll", "<cmd>LspInfo<cr>", desc = "LSP Info", buffer = args.buf},
      })
      if client and client.name == "jdtls" then
        wk.add({
          {"<leader>ct", require("jdtls.tests").goto_subjects, desc = "Goto Subjects", buffer = args.buf},
          {"<leader>cI", require("jdtls").super_implementation, desc = "Goto Super", buffer = args.buf},
        })
      end
    end,
  })
end
