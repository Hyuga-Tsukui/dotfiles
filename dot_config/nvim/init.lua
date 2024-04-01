if not vim.g.vscode then
	local opt = vim.opt
	opt.tabstop = 4
	opt.expandtab = true
	opt.shiftwidth = 4
	opt.smartindent = true
	opt.clipboard:append("unnamedplus")
    opt.relativenumber = true

	-- manage plugins.
	vim.cmd.packadd("packer.nvim")
	require("packer").startup(function()
		use("wbthomason/packer.nvim")
		-- use("rstacruz/vim-closer")
        use("cohama/lexima.vim")
		use({
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

				-- OCaml.
				if lspconfig.ocamllsp then
					lspconfig.ocamllsp.setup({})
				end

				-- Go.
				if lspconfig.gopls then
					lspconfig.gopls.setup({})
				end

                if lspconfig.terraformls then
                    lspconfig.terraformls.setup{}
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
		})
		use({
			"nvimtools/none-ls.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
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
		})
	end)
end

local keymap = vim.keymap
keymap.set("i", "jj", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<S-k>", "10<UP>")
keymap.set("n", "<S-j>", "10<DOWN>")
keymap.set("n", "<S-h>", "10<LEFT>")
keymap.set("n", "<S-l>", "10<RIGHT>")

keymap.set("v", "<S-k>", "10<UP>")
keymap.set("v", "<S-j>", "10<DOWN>")
keymap.set("v", "<S-h>", "10<LEFT>")
keymap.set("v", "<S-l>", "10<RIGHT>")
