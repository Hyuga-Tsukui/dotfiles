return {
	"dense-analysis/ale",
	config = function()
		local g = vim.g
		g.ale_linters = {
			lua = {},
			javascript = {},
			terraform = { "tflint" },
		}
		g.ale_fixers = {
			lua = { "stylua" },
			javascript = { "biome", "prettier" },
			typescript = { "biome", "prettier" },
			terraform = { "terraform" },
		}
		g.ale_terraform_fmt_options = "--write=true"
		g.ale_fix_on_save = 1
	end,
}
