return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
            sync_install = false,

            auto_install = true,
			ensure_installed = {
                "vimdoc",
                "javascript",
                "typescript",
                "lua",
                "go",
            },
            highlight = {
                enable = true,
            },
		})
	end,
}
