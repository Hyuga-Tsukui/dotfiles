return {
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot" },
		event = { "InsertEnter" },
		build = ":Copilot auth",
		config = function()
			require("copilot").setup({})
			-- require("copilot.suggestion").toggle_auto_trigger()
		end,
	},
}
