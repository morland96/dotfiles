-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()

-- UI
--
config.enable_kitty_graphics = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font Mono", weight = "Medium" },
	{ family = "FiraCode Nerd Font Mono", weight = "Regular" },
})
config.tab_max_width = 30
-- config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = 'Medium' })
config.line_height = 1.10
config.font_size = 14.0
config.enable_tab_bar = true
-- config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 10
-- config.freetype_load_flags = 'NO_HINTING'
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}
config.initial_cols = 180
config.initial_rows = 45
-- config.front_end = "OpenGL"

-- Color scheme:

config.color_scheme = "Dracula (Official)"
config.front_end = "WebGpu"

-- config.colors = {
-- 	tab_bar = {
-- 		-- Setting the bar color to black
-- 		background = "rgba(0,0,0,0)",
-- 	},
-- }

-- config.color_scheme = 'catppuccin-macchiato'

-- Keymaps
local act = wezterm.action
config.keys = {
	-- Tabs
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Panes
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "Enter",
		mods = "SHIFT|CMD",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	-- move panes
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = act.RotatePanes("CounterClockwise"),
	},
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = act.RotatePanes("Clockwise"),
	},
	-- workspace
	{
		key = "W",
		mods = "CTRL|SHIFT",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	-- Prompt for a name to use for a new workspace and switch to it.
	{
		key = "C",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
}
-- Nvim integration
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
})
-- and finally, return the configuration to wezterm
return config
