local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.font = wezterm.font("HackGen Console")
config.font_size = 18
config.color_scheme = "Tokyo Night Moon"
config.window_decorations = "RESIZE"
config.use_ime = true

config.window_padding = {
	bottom = 0,
	top = 0,
	right = 0,
	left = 0,
}

config.audible_bell = "Disabled"

-- config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- keybindigs
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

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
	-- tmux like key
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "%",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Right",
		}),
	},
	{
		key = "h",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
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

return config
