return {
    "sschleemilch/slimline.nvim",
    event = { "BufRead", "BufNewFile" },
    cond = function()
        local exclude_filetypes = { "NvimTree" }
        return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
    end,
    dependencies = "lewis6991/gitsigns.nvim",
    config = function()
        vim.opt.laststatus = 3
        require("slimline").setup({
            components = {
                left = {
                    "mode",
                    "recording",
                    "path",
                    "git",
                },
            },
            style = "fg",
        })
    end,
}
