return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.ocamlformat.with({
					cwd = function(params)
						conf = vim.fn.findfile(".ocamlformat", params.root)
						if conf then
							return vim.fn.fnamemodify(conf, ":p:h")
						end
					end,
				}),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,

				null_ls.builtins.formatting.prettierd.with({
					filetypes = { "html", "json", "js", "tsx", "ts", "css" },
				}),
			},
			on_attach = function(_, bufnr)
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({
						async = true,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end, { buffer = bufnr })
			end,
		})
	end,
}
