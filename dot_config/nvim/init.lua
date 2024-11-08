if not vim.g.vscode then
    require("core.options")
    require("core.keymaps")
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.laststatus = 3

    require("config.lazy")

    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
            end,
        },
    })
end
