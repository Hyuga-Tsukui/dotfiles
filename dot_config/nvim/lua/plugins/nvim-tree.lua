return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-tree").setup({})
        -- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

        -- リサイズ関数を定義
        local function resize_nvim_tree()
            local max_width = 0
            for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
                local line_width = vim.fn.strdisplaywidth(line)
                if line_width > max_width then
                    max_width = line_width
                end
            end
            vim.api.nvim_win_set_width(0, max_width + 10)
        end

        -- NvimTreeが開かれているかチェック
        local function is_nvim_tree()
            local bufname = vim.api.nvim_buf_get_name(0)
            return bufname:match("NvimTree_") ~= nil
        end

        -- NvimTreeToggleの後にリサイズ処理を追加
        vim.keymap.set("n", "<leader>e", function()
            vim.cmd("NvimTreeToggle")
            -- 遅延してリサイズを実行
            vim.defer_fn(function()
                if is_nvim_tree() then
                    resize_nvim_tree()
                end
            end, 50) -- 50ms 待機（NvimTreeが開かれるのを待つ）
        end, { desc = "Toggle NvimTree and resize" })
    end,
}
