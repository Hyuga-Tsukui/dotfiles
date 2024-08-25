return {
	"ibhagwan/fzf-lua",
	config = function()
		vim.keymap.set("c", "<C-r>", "<C-c>:FzfLua command_history<CR>", { noremap = true, silent = true })
	end,
}
