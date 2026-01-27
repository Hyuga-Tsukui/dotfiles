local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.font = wezterm.font("UDEV Gothic 35NF", { weight = "Bold" })
config.font_size = 17
config.macos_window_background_blur = 20
config.window_background_opacity = 0.9
config.line_height = 1.1
config.colors = require("cyberdream")
config.color_scheme = "Kanagawa Dragon (Gogh)"
config.window_decorations = "RESIZE"
config.use_ime = true

config.window_padding = {
	bottom = 0,
	top = 16,
	right = 16,
	left = 16,
}

config.audible_bell = "Disabled"

config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.hide_tab_bar_if_only_one_tab = true

local act = wezterm.action

config.keys = {
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	-- disabled tab activation.
	{
		key = "t",
		mods = "CMD",
		action = act.DisableDefaultAssignment,
	},
	-- {
	-- 	key = "n",
	-- 	mods = "CMD",
	-- 	action = act.DisableDefaultAssignment,
	-- },
	-- Quick Select To Open URL.
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://\\S+",
			},
			skip_action_on_paste = true,
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
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

-- zshのAltキーで特殊文字を送信する設定
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

return config
