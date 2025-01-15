return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			transparent = true,
		})
		vim.cmd([[colorscheme cyberdream]])

		vim.api.nvim_set_hl(0, "IncSearch", { bg = "NONE", bold = true, reverse = true })
		vim.api.nvim_set_hl(0, "Search", { bg = "NONE", bold = true, reverse = true })
	end,
}
