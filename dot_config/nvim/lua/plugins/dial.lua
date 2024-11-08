return {
	"monaqa/dial.nvim",
	keys = {
		"<C-a>",
		"<C-x>",
		"g<C-a>",
		"g<C-x>",
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- -- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.constant.alias.bool, -- boolean value (true <-> false)
			},
		})
		vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal("default"), { noremap = true })
		vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal("default"), { noremap = true })
		vim.keymap.set("n", "g<C-a>", require("dial.map").inc_normal("default"), { noremap = true })
		vim.keymap.set("n", "g<C-x>", require("dial.map").dec_normal("default"), { noremap = true })
		vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual("default"), { noremap = true })
		vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual("default"), { noremap = true })
		vim.keymap.set("v", "g<C-a>", require("dial.map").inc_visual("default"), { noremap = true })
		vim.keymap.set("v", "g<C-x>", require("dial.map").dec_visual("default"), { noremap = true })
	end,
}
