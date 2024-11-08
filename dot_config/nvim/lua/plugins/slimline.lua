return {
	"sschleemilch/slimline.nvim",
	event = "VimEnter",
	dependencies = "lewis6991/gitsigns.nvim",
	config = function()
		require("slimline").setup({
			components = {
				left = {
					"mode",
					"recording",
					"path",
					"git",
				},
			},
			style = "fg",
		})
	end,
}
