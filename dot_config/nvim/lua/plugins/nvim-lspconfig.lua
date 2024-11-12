return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
		cmd = { "Mason" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup_handlers({
				-- 1. デフォルトのハンドラー
				-- すべてのサーバーに対して共通の設定を適用
				function(server_name)
					lspconfig[server_name].setup({})
				end,

				-- 2. 特定のサーバーに対するカスタム設定
				-- 例：rust_analyzer の場合、rust-tools を使用した設定
				-- ["rust_analyzer"] = function()
				-- 	require("rust-tools").setup({})
				-- end,
				["lua_ls"] = function()
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
				end,

				-- ["terraformls"] = function()
				-- 	lspconfig.terraformls.setup({
				-- 		on_attach = function(client, _)
				-- 			client.server_capabilities.semanticTokensProvider = nil
				-- 		end,
				-- 	})
				-- end,

				["typos_lsp"] = function()
					lspconfig.typos_lsp.setup({
						init_options = {
							config = "~/.config/typos/.typos.toml",
						},
					})
				end,
			})

			-- Lsp Keymaps.
			-- global.
			-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
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
	},
}
