-- bootstrap lazy.nvim, LazyVim and your plugins
if not vim.g.vscode then
  require("config.lazy")
else
  require("config.vscode")
  vim.cmd("set notimeout")
end
-- Neovide Configuration
if vim.g.neovide then
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_cursor_trail_size = 0.1
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_scroll_animation_length = 3

  vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h14"
  -- vim.o.guifont = "Menlo:h14"
  -- vim.o.guifont = "FiraCode Nerd Font Mono:h14"
  -- vim.o.guifont = "SauceCodePro Nerd Font:h14"
  vim.opt.linespace = 5

  -- Allow clipboard copy paste in neovim
  vim.g.neovide_input_use_logo = 1
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

  vim.g.indent_blankline_char = "│"
end

vim.g.autoformat = false
