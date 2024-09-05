return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	event = { "BufEnter" },
	config = function()
		vim.keymap.set("n", "<TAB>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<S-TAB>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
	end,
}
