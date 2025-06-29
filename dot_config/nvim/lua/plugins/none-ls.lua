return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-null-ls.nvim",
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {},
        })
    end,
}
