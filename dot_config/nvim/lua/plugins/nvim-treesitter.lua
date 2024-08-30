return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- ensure_installed = 'maintained',
            highlight = {
                enable = true,
            },
		})
	end,
}
