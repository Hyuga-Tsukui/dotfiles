local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.font = wezterm.font("Hack")
config.font_size = 18
config.color_scheme = 'tokyonight'

local act = wezterm.action
config.keys = {
	{
		key = "LeftArrow",
		mods = "CMD",
		action = act.SendKey({
			key = "b",
			mods = "META",
		}),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = act.SendKey({
			key = "f",
			mods = "META",
		}),
	},
	{
		key = "Backspace",
		mods = "CMD",
		action = act.SendKey({
			key = "w",
			mods = "CTRL",
		}),
	},
	-- disabled tab activation.
	{
		key = "t",
		mods = "CMD",
		action = act.DisableDefaultAssignment,
	},
}

config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

config.hide_tab_bar_if_only_one_tab = true

return config
