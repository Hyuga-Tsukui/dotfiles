vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>dq", ":lua vim.diagnostic.setloclist()<CR>")

vim.schedule(function()
	vim.keymap.set("n", ";", ":", { noremap = true })
	vim.keymap.set("n", ":", ";", { noremap = true })
end)

-- Toggle relative line numbers
-- vim.keymap.set("n", "<leader>n", function()
--     if vim.wo.relativenumber then
--         vim.wo.number = false
--         vim.wo.relativenumber = false
--     else
--         vim.wo.number = true
--         vim.wo.relativenumber = true
--     end
-- end, { desc = "Toggle relative line numbers" })
