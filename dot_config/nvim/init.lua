vim.cmd [[packadd vim-jetpack]]

local Jetpack = vim.fn['jetpack#add']

vim.call('jetpack#begin')

Jetpack('tani/vim-jetpack', { opt = 1 })
Jetpack('neovim/nvim-lspconfig')
Jetpack('williamboman/mason.nvim', { ['do'] = ':MasonUpdate' })
Jetpack('williamboman/mason-lspconfig.nvim')

Jetpack('hrsh7th/nvim-cmp')
Jetpack('hrsh7th/cmp-nvim-lsp')
Jetpack('hrsh7th/vim-vsnip')

-- Color Schem Plugin
Jetpack('cocopon/iceberg.vim')

-- GitHub Copilot
Jetpack('github/copilot.vim', { config = function()
	vim.g.coplilot_no_tab_map = true

	local keymap = vim.keymap.set
	keymap(
	    "i",
	    "<C-g>",
	    'copilot#Accept("<CR>")',
	    { silent = true, expr = true, script = true, replace_keycodes = false }
	)
	keymap("i", "<C-j>", "<Plug>(copilot-next)")
	keymap("i", "<C-k>", "<Plug>(copilot-previous)")
	keymap("i", "<C-o>", "<Plug>(copilot-dismiss)")
	keymap("i", "<C-s>", "<Plug>(copilot-suggest)")
end,
})

-- Git
Jetpack('nvim-lua/plenary.nvim')
Jetpack('TimUntersberger/neogit')

-- fuzzy finder
Jetpack('ibhagwan/fzf-lua')

-- code acction hook.
Jetpack('jose-elias-alvarez/null-ls.nvim')

vim.call('jetpack#end')

-- LSP Server management
require('mason').setup()
require('mason-lspconfig').setup()

-- Automatically setup LSP server
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function (client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
            false
        )
    end
    require('mason-lspconfig').on_attach(client, bufnr)
end

local lspconfig_handlers = {
	function (server)
		require('lspconfig')[server].setup({ capabilities = capabilities, on_attach = on_attach })
	end,
	["gopls"] = function ()
	 	lspconfig.gopls.setup {
			capabilities = capabilities,
			cmd = {"gopls", "serve"},
			filetypes = {"go", "gomod"},
			on_attach = on_attach,
			settings = {
				gopls = {
					completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    },
				},
			},
	 	}
	 end,
}
require('mason-lspconfig').setup_handlers(lspconfig_handlers)

-- LSP code acction
local null_ls = require('null-ls')
local soruces = {
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
}
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
null_ls.setup(
    {
        ft = 'go',
        sources = soruces,
        on_attach = function (client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({
                    group = augroup,
                    buffer = bufnr,
                })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function ()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
    }
)

-- build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	callback = function (args)
-- 		local buffer = args.buf
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		 vim.cmd[[
-- 		 " let s:bl = ['json'] " set blacklist filetype
-- 		 augroup lsp_document_highlight
-- 		   " autocmd! * <buffer>
-- 		   " autocmd CursorHold,CursorHoldI <buffer> if index(s:bl, &ft) < 0 | lua vim.lsp.buf.document_highlight()
-- 		   " autocmd CursorMoved,CursorMovedI <buffer> if index(s:bl, &ft) < 0 | lua vim.lsp.buf.clear_references()
-- 		   autocmd! * <buffer>
-- 		   autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
-- 		   autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
-- 		 augroup END
-- 		 ]]
-- 	end,
-- })

vim.cmd [[
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
]]
-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})


-- Neogit setup
local neogit = require('neogit')
neogit.setup {}

-- fzf-lua setup
local fzf = require('fzf-lua')
fzf.setup {}

-- colorscheme -----------------------------------------------------------------
-- vim.g.everforest_enable_italic = 0
-- vim.g.everforest_disable_italic_comment = 1
-- require('neosolarized').setup()
vim.cmd [[
autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none
autocmd ColorScheme * highlight Folded ctermbg=none guibg=none
autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none
autocmd ColorScheme * highlight link FloatBorder NormalFloat
autocmd ColorScheme * highlight Search guifg=#222240 guibg=#77A0E0

colorscheme iceberg

highlight LspReferenceText  ctermbg=8 guibg=#305090
highlight LspReferenceRead  ctermbg=8 guibg=#305090
highlight LspReferenceWrite ctermbg=8 guibg=#305090

highlight link LspFloatWinNormal NormalFloat

highlight FzfLuaNormal guibg=#383850
highlight FzfLuaBorder guibg=#383850 gui=bold
]]

-- vim settings ----------------------------------------------------------------
-- appearance 
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.title = true
vim.opt.wrap = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- indent
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

-- log
vim.opt.history = 5000
vim.opt.swapfile = false  -- disable swap file

vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 500

-- keymap
vim.g.mapleader = " "
vim.keymap.set('i', 'jj', '<ESC>')
