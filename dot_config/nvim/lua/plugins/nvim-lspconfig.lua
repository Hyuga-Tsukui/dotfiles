return {
	"neovim/nvim-lspconfig",
	config = function()
		local status_ok, lspconfig = pcall(require, "lspconfig")
		if not status_ok then
			print("lspconfig is not installed")
			return
		end

		-- Start Language server.

		-- Lua.
		if lspconfig.lua_ls then
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = {
								"vim",
							},
						},
					},
				},
			})
		end

		-- TypeScript.
		if lspconfig.ts_ls then
			lspconfig.ts_ls.setup({})
		end

		-- OCaml.
		if lspconfig.ocamllsp then
			lspconfig.ocamllsp.setup({})
		end

		-- Go.
		if lspconfig.gopls then
			lspconfig.gopls.setup({})
		end

		if lspconfig.terraformls then
			lspconfig.terraformls.setup({})
		end

		-- Lsp Keymaps.
		-- global.
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<space>k", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end,
		})
	end,
}
