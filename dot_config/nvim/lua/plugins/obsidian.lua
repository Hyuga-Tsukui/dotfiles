return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
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
        attachments = {
            img_folder = "003_ext",
        },
        open_notes_in = "vsplit", -- how to open notes, can be "vsplit", "split", "tab", "edit"
        daily_notes = {
            folder = "002_daily",
            date_format = "%Y-%m-%d",
        },

        templates = {
            folder = "999_conf/templates",
        },
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
