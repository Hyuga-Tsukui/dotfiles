local ensure_jetpack = function ()
  local fn = vim.fn
  local jetpackfile = fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
  local jetpackurl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
  if fn.filereadable(jetpackfile) == 0 then
    fn.system('curl -fsSLo ' .. jetpackfile .. ' --create-dirs ' .. jetpackurl)
  end
end

local jetpack_bootstrap = ensure_jetpack()

vim.cmd([[
  augroup jetpack_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | JetpackSync
  augroup end
]])

local status, jetpack = pcall(require, "jetpack")
if not status then
  return
end

vim.cmd('packadd vim-jetpack')
jetpack.startup(function (use)

  -- lsp plugins
  use 'neovim/nvim-lspconfig'
  use {'williamboman/mason.nvim', ['do'] = ':MasonUpdate'}
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/vim-vsnip'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- color schem
  use 'cocopon/iceberg.vim'

  use {'github/copilot.vim', config = function ()
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
  end
  }

  -- Git
  use {'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim'}}

  -- fuzzy finder
  use 'ibhagwan/fzf-lua'
end)
