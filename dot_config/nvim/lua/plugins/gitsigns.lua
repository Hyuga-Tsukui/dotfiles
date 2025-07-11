return {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    cond = function()
        -- 現在のバッファのファイルタイプが特定のもの (例: NvimTree) でないことを確認
        local exclude_filetypes = { "NvimTree" }
        return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
    end,

    config = function()
        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Actions
                map("n", "<leader>hs", gitsigns.stage_hunk)
                map("n", "<leader>hu", gitsigns.undo_stage_hunk)
                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("v", "<leader>hu", function()
                    gitsigns.undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
            end,
            numhl = true,
            signcolumn = true,
        })
    end,
}
