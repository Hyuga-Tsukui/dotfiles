return {
    "kevinhwang91/nvim-hlslens",
    config = function()
        local hlslens = require("hlslens")
        hlslens.setup({})

        local kopts = { noremap = true, silent = true }

        vim.keymap.set("n", "*", function()
            local cword = vim.fn.expand("<cword>")
            vim.fn.histadd("search", cword)
            vim.fn.setreg("/", cword)
            vim.opt.hlsearch = true
            hlslens.start()
        end, kopts)

        -- replace the current word with the cursor position
        vim.keymap.set("n", "#", function()
            local current_word = vim.fn.expand("<cword>")
            vim.api.nvim_feedkeys(":%s/" .. current_word .. "//g", "n", false)
            -- :%s/word/CURSOR/g
            local ll = vim.api.nvim_replace_termcodes("<Left><Left>", true, true, true)
            vim.api.nvim_feedkeys(ll, "n", false)
            vim.opt.hlsearch = true
            hlslens.start()
        end, opts)

        vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
}
