-- bootstrap lazy.nvim, LazyVim and your plugins
if not vim.g.vscode then
  require("config.lazy")
else
  require("config.vscode")
  vim.cmd("set notimeout")
end
-- Neovide Configuration
if vim.g.neovide then
  vim.g.neovide_input_macos_option_key_is_meta = "both"
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_cursor_trail_size = 0.1
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_scroll_animation_length = 0.15
  vim.g.neovide_floating_shadow = false

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

  vim.opt.winblend = 20
  vim.opt.pumblend = 50

  -- Terminal colour
  vim.g.terminal_color_0 = "#45475a"
  vim.g.terminal_color_1 = "#f38ba8"
  vim.g.terminal_color_2 = "#a6e3a1"
  vim.g.terminal_color_3 = "#f9e2af"
  vim.g.terminal_color_4 = "#89b4fa"
  vim.g.terminal_color_5 = "#f5c2e7"
  vim.g.terminal_color_6 = "#94e2d5"
  vim.g.terminal_color_7 = "#bac2de"
  vim.g.terminal_color_8 = "#585b70"
  vim.g.terminal_color_9 = "#f38ba8"
  vim.g.terminal_color_10 = "#a6e3a1"
  vim.g.terminal_color_11 = "#f9e2af"
  vim.g.terminal_color_12 = "#89b4fa"
  vim.g.terminal_color_13 = "#f5c2e7"
  vim.g.terminal_color_14 = "#94e2d5"
  vim.g.terminal_color_15 = "#a6adc8"
end

vim.g.autoformat = false
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"
vim.g.snacks_animate = false
vim.opt.termguicolors = true
vim.opt.winblend = 10
vim.opt.pumblend = 30
