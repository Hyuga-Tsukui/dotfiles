return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			-- available: devicons, mini, default is mini
			-- if provider not loaded and enabled is true, it will try to use another provider
			startify.section.top_buttons.val = {
				startify.button("e", "New file", ":ene <BAR> startinsert <CR>"),
				startify.button("f", "Find file", ":FzfLua files<CR>"),
				startify.button("s", "Settings", ":e $HOME/.config/nvim <CR>"),
			}
			require("alpha").setup(startify.config)
		end,
	},
}
