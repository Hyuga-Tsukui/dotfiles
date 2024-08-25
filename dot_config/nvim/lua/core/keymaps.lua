vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

vim.keymap.set("c", "<C-r>", "<C-c>:FzfLua command_history<CR>", { noremap = true, silent = true })



vim.keymap.set("n", "<leader>dq", ":lua vim.diagnostic.setloclist()<CR>")
