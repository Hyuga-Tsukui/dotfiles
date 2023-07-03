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
Jetpack('NeogitOrg/neogit')

-- fuzzy finder
Jetpack('ibhagwan/fzf-lua')

-- code acction hook.
Jetpack('jose-elias-alvarez/null-ls.nvim')

vim.call('jetpack#end')
