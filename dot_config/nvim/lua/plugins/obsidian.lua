return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    cmd = {
        "ObsidianNew",
        "ObsidianSearch",
        "ObsidianLink",
        "ObsidianBacklinks",
        "ObsidianToday",
        "ObsidianYesterday",
        "ObsidianWeekly",
        "ObsidianQuickSwitch",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
        "hrsh7th/nvim-cmp",
    },
    opts = {
        -- global options
        sort_by = "modified", -- list note sorting
        ui = {
            enabled = false, -- use original obsidian ui like
        },
        statusline = {
            enabled = true, -- enable obsidian statusline
            format = " 󰌪 {{workspace}}",
        },
        open_notes_in = "vsplit", -- how to open notes, can be "vsplit", "split", "tab", "edit"
        daily_notes = {
            -- デイリーノートを "Journal/Dailies" フォルダに保存する
            folder = "002_daily",

            -- ファイル名を "2025-06-27" の形式にする
            date_format = "%Y-%m-%d",

            -- "June 27, 2025" という形式のエイリアスを自動で付ける
            -- alias_format = "%B %d, %Y",

            -- -- 新規作成時に "daily_template.md" というテンプレートを使用する
            -- template = "daily_template.md",
        },

        -- テンプレートが置かれているフォルダを指定
        -- templates = {
        --     folder = "meta/templates",
        --     -- ... 他のテンプレート設定 ...
        -- },
        workspaces = {
            {
                name = "personal",
                path = vim.fn.expand("~/obsidian"),

                -- options for this workspace
                overrides = {
                    notes_subdir = "000_zettelkasten",
                },
            },
            {
                name = "work",
                path = vim.fn.expand("~/obsidian-work"),
                -- options for this workspace
                overrides = {},
            },
        },
    },
    keys = {
        { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian: New note" },
        { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian: Search notes" },
        { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Obsidian: Link notes" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian: Backlinks" },
        { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian: Today note" },
        { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Obsidian: Yesterday note" },
        { "<leader>ow", "<cmd>ObsidianWeekly<cr>", desc = "Obsidian: Weekly note" },
        { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian: Quick switch" },
    },
}
