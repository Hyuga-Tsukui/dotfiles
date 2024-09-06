vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- vim.keymap.set("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-j>", ":bprev<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", '"_dp')

if not vim.g.vscode then
	-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
	-- vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>", { noremap = true })
	-- vim.keymap.set("n", "<leader>dq", ":lua vim.diagnostic.setloclist()<CR>")
end
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
