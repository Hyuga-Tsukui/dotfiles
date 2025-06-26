local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.font = wezterm.font("HackGen Console")
config.font_size = 18
config.window_background_opacity = 0.8
config.macos_window_background_blur = 100
config.line_height = 1.1
config.colors = require("cyberdream")
config.window_decorations = "RESIZE"
config.use_ime = true

config.window_padding = {
	bottom = 0,
	top = 0,
	right = 0,
	left = 0,
}

config.audible_bell = "Disabled"

config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.hide_tab_bar_if_only_one_tab = true

-- keybindigs
-- config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
local act = wezterm.action

config.keys = {
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	-- disabled tab activation.
	{
		key = "t",
		mods = "CMD",
		action = act.DisableDefaultAssignment,
	},
	{
		key = "n",
		mods = "CMD",
		action = act.DisableDefaultAssignment,
	},
}

-- 現在の`copy_mode`のデフォルト設定を取得
local current_copy_mode = wezterm.gui.default_key_tables().copy_mode

-- 新しいキーアクションをマージ
table.insert(current_copy_mode, {
	key = "Enter",
	mods = "NONE",
	action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
})

-- マージした設定を反映
config.key_tables = {
	copy_mode = current_copy_mode,
}

config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

-- config.default_prog = { "zsh", "-l", "-c", "tmux a -t default || tmux new -s default" }

return config
