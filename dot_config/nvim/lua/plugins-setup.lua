local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("cohama/lexima.vim")
	use("ibhagwan/fzf-lua")

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

			-- TypeScript.
			if lspconfig.tsserver then
				lspconfig.tsserver.setup({})
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
	-- Lsp Complement.
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}),
		{ name = "buffer" },
	})

	-- Color
	use("folke/tokyonight.nvim")
	use({
		"glidenote/memolist.vim",
		config = function()
			vim.g.memolist_path = vim.fn.expand("~/.config/memo/_posts")
		end,
	})

	-- obsidian
	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "personal",
						path = vim.fn.expand("~/obsidian"),
					},
				},

				-- see below for full list of options 👇
				disable_frontmatter = true,
				note_id_func = function(title)
					-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
					-- In this case a note with the title 'My new note' will be given an ID that looks
					-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
					local suffix = ""
					if title ~= nil then
						-- If title is given, transform it into valid file name.
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						-- If title is nil, just add 4 random uppercase letters to the suffix.
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,
			})
		end,
	})
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if ensure_packer() then
		require("packer").sync()
	end
end)
