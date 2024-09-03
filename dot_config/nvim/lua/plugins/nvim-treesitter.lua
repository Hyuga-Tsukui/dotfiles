return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			sync_install = false,

			ignore_install = {
				"markdown",
			},

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
        -- REF: https://github.com/nvim-treesitter/nvim-treesitter/issues/2825#issuecomment-1547409415
		vim.api.nvim_create_autocmd({
			"BufEnter",
			"BufWinEnter",
		}, {
			pattern = { "*.md" },
			callback = function()
				vim.cmd("set conceallevel=0")
			end,
		})
		vim.api.nvim_create_autocmd({
			"BufLeave",
			"BufWinLeave",
		}, {
			pattern = { "*.md" },
			callback = function()
				vim.cmd("set conceallevel=3")
			end,
		})
	end,
}
