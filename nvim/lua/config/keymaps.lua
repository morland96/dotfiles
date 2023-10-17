-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

local map = vim.keymap.set
local nx = { "n", "x" }


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

  -- Kitty
  map(nx, "<C-h>", "<cmd>:KittyNavigateLef<cr>")
  map(nx, "<C-j>", "<cmd>:KittyNavigateDown<cr>")
  map(nx, "<C-k>", "<cmd>:KittyNavigateUp<cr>")
  map(nx, "<C-l>", "<cmd>:KittyNavigateRight<cr>")

  -- Telescope
  local telescope_builtin = require("telescope.builtin")
  map("n", "<Leader>pp", "<Cmd>Telescope projects<CR>", { desc = "Find Projects" })
  map("n", "<Leader>pf", "<Cmd>Telescope find_files<CR>", { desc = "Find Project Files" })
  map("n", "<Leader>p.", "<Cmd>Telescope file_browser<CR>", { desc = "Browse Project Files" })
  map("n", "<Leader>pg", telescope_builtin.live_grep, { desc = "Grep Project Files" })

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
  map("n", "<Leader>js", telescope_builtin.treesitter, { desc = "Jump treesitter" })

  -- Search
  map("n", "<Leader>ss", telescope_builtin.lsp_document_symbols, { desc = "Search symbols in file" })
  map("n", "<Leader>s.", telescope_builtin.builtin, { desc = "Telescope search" })
  map("n", "<Leader>sS", telescope_builtin.lsp_dynamic_workspace_symbols, { desc = "Search symbols in workspace" })

  -- Goto
  map("n", "<Leader>ci", telescope_builtin.lsp_implementations, { desc = "Goto Implementation" })

  -- Bookmarks
  local bm = require("telescope").extensions.vim_bookmarks
  map(nx, "<Leader><enter>", bm.all, { desc = "List Bookmarks" })
  map(nx, "<Leader>mm", "<Cmd>BookmarkToggle<CR>", { desc = "Toggle Bookmark" })
  map(nx, "<Leader>mi", "<Cmd>BookmarkAnnotate<CR>", { desc = "Bookmark Annotate" })
  map(nx, "<Leader>mn", "<Cmd>BookmarkNext<CR>", { desc = "Next Bookmark" })
  map(nx, "<Leader>mp", "<Cmd>BookmarkPrev<CR>", { desc = "Previous Bookmark" })
  map(nx, "<Leader>ml", bm.all, { desc = "List Bookmarks" })
  map(nx, "<Leader>mc", "<Cmd>BookmarkClear<CR>", { desc = "Clear Bookmarks" })
  map(nx, "<Leader>mx", "<Cmd>BookmarkClearAll<CR>", { desc = "Clear All Bookmarks" })

  -- Harpoon
  local h_ui = require("harpoon.ui")
  local h_m = require("harpoon.mark")
  map("n", "<Leader><enter>", h_ui.toggle_quick_menu, { desc = "Harpoon Menu" })
  map("n", "<Leader>hh", h_ui.toggle_quick_menu, { desc = "Harpoon Menu" })
  map("n", "<Leader>hl", "<cmd>Telescope harpoon marks<cr>", { desc = "Harpoon Menu" })
  map("n", "<Leader>ha", h_m.add_file, { desc = "Harpoon Add File" })
  map("n", "<Leader>hd", h_m.rm_file, { desc = "Harpoon Delete File" })
  map("n", "<Leader>hn", h_ui.nav_next, { desc = "Harpoon Next File" })
  map("n", "<Leader>hp", h_ui.nav_prev, { desc = "Harpoon Previous File" })
  map("n", "<C-1>", "<cmd> lua require('harpoon.ui').nav_file(1)<cr>", { desc = "file 1" })
  map("n", "<C-2>", "<cmd> lua require('harpoon.ui').nav_file(2)<cr>", { desc = "file 2" })
  map("n", "<C-3>", "<cmd> lua require('harpoon.ui').nav_file(3)<cr>", { desc = "file 3" })
  map("n", "gh", h_ui.nav_next, { desc = "Harpoon next file" })
  map("n", "gl", h_ui.nav_prev, { desc = "Harpoon previous file" })
  map("n", "<D-p>", h_ui.nav_next)
  map("n", "<D-n>", h_ui.nav_prev)

  -- Refactor
  map("n", "<Leader>rr", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<Leader>ra", vim.lsp.buf.code_action, { desc = "Code Action" })


  -- Java
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == "jdtls" then
        local wk = require("which-key")
        wk.register({
          ["<leader>ct"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
          ["<leader>cI"] = { require("jdtls").super_implementation, "Goto Super" },
        }, {
            mode = "n", buffer = args.buf
        })
      end
    end,
  })
end
