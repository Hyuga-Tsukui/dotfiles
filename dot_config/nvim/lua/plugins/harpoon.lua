return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		"<leader>m",
		"<C-e>",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		-- Add a new harpoon mark
		vim.keymap.set("n", "<leader>m", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
	end,
}
