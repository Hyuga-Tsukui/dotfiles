return {
	"ibhagwan/fzf-lua",
	keys = {
		"<C-p>",
		"<C-r>",
	},
	cmd = "FzfLua",
	config = function()
		require("fzf-lua").setup({
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept", -- send quick fix to quickfix list
				},
			},
			actions = {
				files = {
					["ctrl-b"] = function()
						require("fzf-lua").buffers()
					end,
				},
				buffers = {
					["ctrl-f"] = function()
						require("fzf-lua").files()
					end,
				},
			},
		})
		vim.keymap.set("n", "<C-p>f", ":FzfLua files<CR>", { noremap = true })
		vim.keymap.set("n", "<C-p>b", ":FzfLua buffers<CR>", { noremap = true })
		vim.keymap.set("c", "<C-r>", "<C-c>:FzfLua command_history<CR>", { noremap = true, silent = true })
	end,
}
