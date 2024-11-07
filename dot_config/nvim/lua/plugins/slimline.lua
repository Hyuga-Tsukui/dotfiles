return {
	"sschleemilch/slimline.nvim",
	event = "VimEnter",
	dependencies = "lewis6991/gitsigns.nvim",
	config = function()
		require("slimline").setup({
			components = {
				left = {
					"mode",
					function()
						local h = require("slimline.highlights")
						local recording = vim.fn.reg_recording()
						if recording ~= "" then
							return h.hl_component({ primary = "recording @" .. recording }, h.hls.component, {
								hide = {
									first = true,
									last = true,
								},
							})
						end
						return ""
					end,
					"path",
					"git",
				},
			},
			style = "fg",
			sep = {
				hide = {
					first = true,
					last = true,
				},
			},
		})
	end,
}
