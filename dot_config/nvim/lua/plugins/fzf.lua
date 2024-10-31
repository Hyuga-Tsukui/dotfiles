return {
	"ibhagwan/fzf-lua",
	config = function()
		vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>", { noremap = true })
		vim.keymap.set("c", "<C-r>", "<C-c>:FzfLua command_history<CR>", { noremap = true, silent = true })
	end,
}
