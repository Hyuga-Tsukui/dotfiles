vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>dq", ":lua vim.diagnostic.setloclist()<CR>")

vim.schedule(function()
   vim.keymap.set("n", ";", ":", { noremap = true })
   vim.keymap.set("n", ":", ";", { noremap = true })
end)
