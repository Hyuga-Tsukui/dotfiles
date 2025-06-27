return {
    "ibhagwan/fzf-lua",
    version = "*",
    keys = {
        "<C-p>",
        "<C-r>",
    },
    cmd = "FzfLua",
    config = function()
        -- keep the default actions
        local actions = require("fzf-lua").actions
        require("fzf-lua").setup({
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept", -- send quick fix to quickfix list
                },
            },
            actions = {
                files = {
                    ["ctrl-b"] = function() -- switch to buffers
                        require("fzf-lua").buffers()
                    end,
                    ["default"] = actions.file_edit,
                },
                buffers = {
                    ["ctrl-f"] = function() -- switch to files
                        require("fzf-lua").files()
                    end,
                    ["default"] = actions.file_edit,
                },
            },
        })
        -- vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", { noremap = true })
        vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", { noremap = true })
        vim.keymap.set("c", "<C-r>", "<C-c>:FzfLua command_history<CR>", { noremap = true, silent = true })
    end,
}
