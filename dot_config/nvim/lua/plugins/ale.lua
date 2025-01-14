return {
	"dense-analysis/ale",
	config = function()
		local g = vim.g
		g.ale_linters = {
			lua = {},
			javascript = {},
		}
		g.ale_fixers = {
			lua = { "stylua" },
			javascript = { "biome", "prettier" },
			typescript = { "biome", "prettier" },
		}
		g.ale_fix_on_save = 1
	end,
}
