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
		})
	end,
}
