vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "<leader>dq", ":lua vim.diagnostic.setloclist()<CR>")

vim.keymap.set("n", "<C-j>", ":bprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>", { noremap = true })
