return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    event = { "BufRead", "BufNewFile" },
    cond = function()
        local exclude_filetypes = { "NvimTree" }
        return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
    end,
    config = function()
        require("barbar").setup({
            sidebar_filetypes = {
                -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
                NvimTree = true,
                -- Or, specify the text used for the offset:
                undotree = {
                    text = "undotree",
                    align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
                },
                -- Or, specify the event which the sidebar executes when leaving:
                ["neo-tree"] = { event = "BufWipeout" },
                -- Or, specify all three
                Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
            },
            animation = false,
        })
        vim.keymap.set("n", "<TAB>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<S-TAB>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>p", "<Cmd>BufferPick<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>w", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ac", "<Cmd>BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })
    end,
}
