return {
	"williamboman/mason-null-ls.nvim",
	lazy = true,
	config = function()
		require("mason")
		require("mason-null-ls").setup({
			automatic_installation = false,
			handlers = {},
		})
	end,
}
