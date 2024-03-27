-- require("plugins-setup")
-- require("core.options")
-- require("core.keymaps")
-- require('core.colorscheme')
-- require('plugins.fern-setup')
-- require('plugins.lsp-setup')
-- require('plugins.git-client')
-- require('plugins.fzf-setup')

if not vim.g.vscode then
	local opt = vim.opt
	opt.number = true	
	opt.clipboard:append("unnamedplus")
	
	-- manage plugins.
	vim.cmd.packadd "packer.nvim"
	require("packer").startup(function()
		use 'wbthomason/packer.nvim' 
		use 'rstacruz/vim-closer'
		use {
			'neovim/nvim-lspconfig',
			config = function()
				require('lspconfig').ocamllsp.setup{}
				vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
				vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
			end,
		}
	end)

end

local keymap = vim.keymap
keymap.set('i', 'jj', '<ESC>')
keymap.set('n', '<leader>nh', ':nohl<CR>')

keymap.set('n', '<S-k>', '10<UP>')
keymap.set('n', '<S-j>', '10<DOWN>')
keymap.set('n', '<S-h>', '10<LEFT>')
keymap.set('n', '<S-l>', '10<RIGHT>')

keymap.set('v', '<S-k>', '10<UP>')
keymap.set('v', '<S-j>', '10<DOWN>')
keymap.set('v', '<S-h>', '10<LEFT>')
keymap.set('v', '<S-l>', '10<RIGHT>')
