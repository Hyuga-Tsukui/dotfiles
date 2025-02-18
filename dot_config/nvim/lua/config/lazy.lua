if not vim.g.vscode then
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out,                            "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)
    require("lazy").setup({
        require("plugins.Comment"),
        require("plugins.barbar"),
        require("plugins.color-scheme"),
        require("plugins.copilot"),
        require("plugins.dial"),
        require("plugins.fidget"),
        require("plugins.fzf"),
        require("plugins.gitsigns"),
        require("plugins.harpoon"),
        require("plugins.hlchunk"),
        require("plugins.lexima"),
        require("plugins.mason-null-ls"),
        require("plugins.mason-nvim"),
        require("plugins.memolist"),
        require("plugins.no-neck-pain"),
        require("plugins.none-ls"),
        require("plugins.nvim-cmp"),
        require("plugins.nvim-lspconfig"),
        require("plugins.nvim-surround"),
        require("plugins.nvim-tree"),
        require("plugins.nvim-treesitter"),
        require("plugins.obsidian"),
        require("plugins.slimline"),
        require("plugins.tmux-navigator"),
        require("plugins.vim-maketable"),
        require("plugins.alpha-nvim"),
        require("plugins.nvim-hlslens"),
        require("plugins.auto-session"),
        require("plugins.which-key-nvim"),
        require("plugins.gitlinker"),
    })
end
