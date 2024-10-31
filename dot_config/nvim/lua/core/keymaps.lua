vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- vim.keymap.set("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-j>", ":bprev<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "x", '"_x"', { noremap = true, silent = true })
-- vim.keymap.set("n", "X", '"_D"', { noremap = true, silent = true })
-- vim.keymap.set("x", "x", '"_x"', { noremap = true, silent = true })
-- vim.keymap.set("o", "x", "d", { noremap = true, silent = true })
--
-- vim.keymap.set("o", "i<space>", "iW", { noremap = true, silent = true })
-- vim.keymap.set("x", "i<space>", "iW", { noremap = true, silent = true })

if not vim.g.vscode then
	vim.keymap.set("n", "<leader>dq", ":lua vim.diagnostic.setloclist()<CR>")
end
