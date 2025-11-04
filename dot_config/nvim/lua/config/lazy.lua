local plugins = {
    -- general
    'plugins.vimdoc-ja',
    'plugins.tmux-navigator',
    'plugins.which-key-nvim',

    -- text editing
    'plugins.dial',
    'plugins.autopairs',
    'plugins.vim-maketable',

    -- UI and appearance
    'plugins.color-scheme',
    'plugins.nvim-hlslens',
    'plugins.alpha',
    'plugins.render-markdown',

    -- Tools and utilities
    'plugins.harpoon',
    'plugins.memolist',
    'plugins.nvim-tree',
    'plugins.copilot.init',
    'plugins.copilot.chat',
    'plugins.toggleterm',
    'plugins.aerial',
    'plugins.overseer',
    'plugins.git',
    'plugins.gitsigns',
    'plugins.gitlinker',
    'plugins.mini',
    'plugins.quicker',
    'plugins.bqf',
    'plugins.obsidian',

    -- LSP and completion
    'plugins.mason-null-ls',
    'plugins.mason-nvim',
    'plugins.nvim-lspconfig',
    'plugins.nvim-treesitter',
    'plugins.nvim-treesitter-textsubjects',
    'plugins.lazydev',
    'plugins.snacks',
    'plugins.blink-cmp',
    'plugins.luasnip',
}

-- this is a workaround for lazy.nvim not being able to load plugins
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local profile = vim.env.NVIM_PROFILE or 'personal'

if profile == 'work' then
    table.insert(plugins, 'plugins.work.gitlinker')
end

require('lazy').setup(vim.tbl_map(require, plugins))
