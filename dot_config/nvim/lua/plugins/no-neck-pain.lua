return {
	"shortcuts/no-neck-pain.nvim",
	-- cmd = {
	-- 	"NoNeckPain",
	-- },
    event = "VimEnter",
	config = function()
		-- vim.api.nvim_create_autocmd({"VimEnter"}, {
		-- 	command = ":NoNeckPain<CR>",
		-- })
        vim.cmd("NoNeckPain")
	end,
}
