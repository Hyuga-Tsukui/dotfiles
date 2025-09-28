local plugins = {
    -- text editing
    'plugins.dial',

    -- UI and appearance
    'plugins.color-scheme',
    'plugins.barbar',
    'plugins.lualine',
    'plugins.hlchunk',
    'plugins.nvim-hlslens',

    -- Tools and utilities
    'plugins.vim-maketable',
    'plugins.gitlinker',
    'plugins.gitsigns',
    'plugins.harpoon',
    'plugins.memolist',
    'plugins.nvim-tree',
    'plugins.obsidian',
    'plugins.which-key-nvim',
    'plugins.tmux-navigator',
    'plugins.copilot.init',
    'plugins.copilot.chat',
    'plugins.toggleterm',
    'plugins.aerial',
    'plugins.overseer',
    'plugins.plamo-translate',

    -- LSP and completion
    'plugins.mason-null-ls',
    'plugins.mason-nvim',
    'plugins.nvim-lspconfig',
    'plugins.nvim-treesitter',
    'plugins.lazydev',
    'plugins.snacks',
    'plugins.blink-cmp',
    'plugins.luasnip',

    -- experimental plugins
    -- 'plugins.comfy-line-numbers',
    'plugins.lsp_signature',
    'plugins.no-neck-pain',
    -- 'plugins.autopairs',
    'plugins.vim-list2tree',
    'plugins.alpha',
    -- 'plugins.flash',
    'plugins.oil',
    'plugins.mini',
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
