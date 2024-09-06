return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = function()
		require("nvim-tree").setup({})
		vim.g.mapleader = " "
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
	end,
}
