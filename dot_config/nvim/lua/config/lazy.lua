local vscode_plugins = {
    "plugins.nvim-surround",
    "plugins.Comment",
    "plugins.dial",
}

local pure_nvim_plugins = {
    "plugins.color-scheme",
    "plugins.vim-maketable",
    "plugins.nvim-hlslens",
    "plugins.gitlinker",
    "plugins.fidget",
    "plugins.barbar",
    "plugins.fzf",
    "plugins.gitsigns",
    "plugins.harpoon",
    "plugins.hlchunk",
    "plugins.lexima",
    "plugins.mason-null-ls",
    "plugins.mason-nvim",
    "plugins.memolist",
    "plugins.no-neck-pain",
    "plugins.none-ls",
    "plugins.nvim-cmp",
    "plugins.nvim-lspconfig",
    "plugins.nvim-tree",
    "plugins.nvim-treesitter",
    "plugins.obsidian",
    "plugins.slimline",
    "plugins.tmux-navigator",
    "plugins.auto-session",
    "plugins.which-key-nvim",
    "plugins.treejs",
    "plugins.copilot.init",
    "plugins.copilot.chat",
    "plugins.make-tree",
    "plugins.plamo-translate",
    "plugins.lazydev",
    "plugins.snacks",
}

-- this is a workaround for lazy.nvim not being able to load plugins
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local enable_plugins = {}

vim.list_extend(enable_plugins, vscode_plugins)

if not vim.g.vscode then
    vim.list_extend(enable_plugins, pure_nvim_plugins)
end

require("lazy").setup(vim.tbl_map(require, enable_plugins))
