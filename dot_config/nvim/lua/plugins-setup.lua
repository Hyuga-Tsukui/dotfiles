local ensure_packer = function()
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
end
return false
end
  
local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
use 'wbthomason/packer.nvim'

use 'lambdalisue/fern.vim'

-- fuzzy finder
use { 'junegunn/fzf', run = ":call fzf#install()" }
use { 'junegunn/fzf.vim' }

-- color scheme
use 'sainnhe/everforest'

-- LSP
use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'
use 'neovim/nvim-lspconfig'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/vim-vsnip'
use { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end
end)
