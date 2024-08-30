local trigger_key = "<C-`>"
local toggle = [[<Cmd>exe v:count1 .. "ToggleTerm"<CR>]]

return {
	"akinsho/toggleterm.nvim",
	keys = { trigger_key },
	config = function()
		require("toggleterm").setup({})

		vim.api.nvim_create_autocmd({ "TermEnter" }, {
			pattern = { "term://*toggleterm#*" },
			callback = function()
				vim.api.nvim_buf_set_keymap(0, "t", trigger_key, toggle, { noremap = true, silent = true })
			end,
		})
        
		vim.api.nvim_set_keymap("n", trigger_key, toggle, { noremap = true, silent = true })
		vim.api.nvim_set_keymap("i", trigger_key, toggle, { noremap = true, silent = true })
	end,
}
