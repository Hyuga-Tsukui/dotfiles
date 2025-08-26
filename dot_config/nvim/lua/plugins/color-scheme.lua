-- return {
--     'scottmckendry/cyberdream.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('cyberdream').setup({
--             transparent = true,
--         })
--         vim.cmd([[colorscheme cyberdream]])
--
--         -- vim.api.nvim_set_hl(0, "Search", { bg = "NONE", bold = true, reverse = true })
--         -- vim.api.nvim_set_hl(0, "CurSearch", { underline = true, bold = true })
--         -- vim.api.nvim_set_hl(0, "Search", { underline = true, bold = true })
--     end,
-- }
return {
    'rose-pine/neovim',
    priority = 1000,
    name = 'rose-pine',
    config = function()
        require('rose-pine').setup({
            variant = 'moon',
        })
        vim.cmd('colorscheme rose-pine')
    end,
}
-- return {
--     'folke/tokyonight.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('tokyonight').setup({
--             style = 'moon',
--         })
--         vim.cmd([[colorscheme tokyonight]])
--     end,
-- }
-- return {
--     'eihigh/vim-aomi-grayscale',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd([[colorscheme aomi-grayscale]])
--     end,
-- }
