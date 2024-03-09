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


--	vim.api.nvim_create_augroup('go', {})
--	vim.api.nvim_create_autocmd("BufWritePre", {
--	    group = 'go',
--	    pattern = "*.go",
--	    callback = function()
--		vim.cmd("silent !go fmt %")
--		vim.cmd("e!")
--	    end,
--	})
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
