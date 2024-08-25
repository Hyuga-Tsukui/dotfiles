return {
	"glidenote/memolist.vim",
	config = function()
		vim.g.memolist_path = vim.fn.expand("~/.config/memo/_posts")
	end,
}
