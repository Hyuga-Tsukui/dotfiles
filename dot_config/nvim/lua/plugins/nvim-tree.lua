return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-tree").setup({})
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

        -- リサイズ関数
        local function resize_nvim_tree(winnr)
            local max_width = 0
            -- winnr のバッファ番号を取得
            local bufnr = vim.api.nvim_win_get_buf(winnr)

            -- 対象のバッファ内容を取得して最大幅を計算
            for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
                local line_width = vim.fn.strdisplaywidth(line)
                if line_width > max_width then
                    max_width = line_width
                end
            end

            -- ウィンドウ幅を設定
            vim.api.nvim_win_set_width(winnr, max_width + 8)
        end

        -- イベント登録
        local function setup_nvim_tree_event()
            local ok, nvim_tree_events = pcall(require, "nvim-tree.events")
            if not ok then
                vim.notify("nvim-tree.events モジュールが読み込めませんでした", vim.log.levels.ERROR)
                return
            end

            -- TreeRendered イベントを監視
            nvim_tree_events.subscribe(nvim_tree_events.Event.TreeRendered, function(payload)
                if vim.api.nvim_buf_get_option(payload.bufnr, "filetype") == "NvimTree" then
                    -- フォーカスを変更せずにリサイズ実行
                    resize_nvim_tree(payload.winnr)
                end
            end)
        end

        -- Neovim 起動時にイベント設定を呼び出す
        vim.api.nvim_create_autocmd("VimEnter", {
            group = vim.api.nvim_create_augroup("NvimTreeSetup", { clear = true }),
            callback = setup_nvim_tree_event,
        })
    end,
}
