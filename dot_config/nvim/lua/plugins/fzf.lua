return {
	"ibhagwan/fzf-lua",
	keys = {
		"<C-p>",
		"<C-r>",
	},
	config = function()
		require("fzf-lua").setup({
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept", -- send quick fix to quickfix list
				},
			},
		})
		vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>", { noremap = true })
		vim.keymap.set("c", "<C-r>", "<C-c>:FzfLua command_history<CR>", { noremap = true, silent = true })
	end,
}
