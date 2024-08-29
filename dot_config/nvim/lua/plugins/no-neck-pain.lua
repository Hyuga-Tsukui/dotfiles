return {
	"shortcuts/no-neck-pain.nvim",
	event = "VimEnter",
	config = function()
		vim.cmd("NoNeckPain")
	end,
}
