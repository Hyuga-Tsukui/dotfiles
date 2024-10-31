return {
	"sschleemilch/slimline.nvim",
	event = "VimEnter",
	dependencies = "lewis6991/gitsigns.nvim",
	config = function()
		require("slimline").setup({
			icons = {
				diagnostics = {
					ERROR = " ",
					WARN = " ",
					HINT = " ",
					INFO = " ",
				},
				git = {
					branch = "",
				},
				folder = " ",
				lines = " ",
			},
			spaces = {
				components = "",
				left = "",
				right = "",
			},
			sep = {
				hide = {
					first = true,
					last = true,
				},
				left = "",
				right = "",
			},
            exclude_ft = {"NvimTree"}
		})
	end,
}
