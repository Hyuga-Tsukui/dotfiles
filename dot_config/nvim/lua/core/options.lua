local opt = vim.opt

-- clipboard
opt.clipboard:append("unnamedplus")
opt.scrolloff = 8

vim.opt.incsearch = true
vim.opt.hlsearch = true

-- ハイライトのトグルを設定
local function toggle_hlsearch(enable)
  vim.opt.hlsearch = enable
end

-- コマンドラインに検索ワード入力が開始されたらハイライトを有効化
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "/,?",
  callback = function()
    toggle_hlsearch(true)
  end,
})

-- 検索確定後（コマンドラインを離れたら）ハイライトをオフに
vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = "/,?",
  callback = function()
    toggle_hlsearch(false)
  end,
})

if not vim.g.vscode then
	-- appearence
	opt.guicursor = ""
	-- line numbers
	opt.nu = true
	opt.relativenumber = true
	opt.cmdheight = 0
	opt.conceallevel = 2

	opt.smartindent = true
	-- tab & indentation
	opt.tabstop = 4
	opt.shiftwidth = 4
	opt.expandtab = true
	opt.autoindent = true

	-- line wrapping
	opt.wrap = false

	-- search settings
	opt.ignorecase = true
	opt.smartcase = true

	-- cursorline
	opt.cursorline = true

	-- appearence
	opt.termguicolors = true
	opt.background = "dark"
	opt.signcolumn = "yes"
	opt.title = true

	-- backspace
	opt.backspace = "indent,eol,start"

	-- split windows
	opt.splitright = true
	opt.splitbelow = true

	-- log
	opt.history = 500
	opt.updatetime = 50

	opt.iskeyword:append("-")

	-- backup
	opt.swapfile = false
	opt.backup = false

	local undodir = vim.fn.stdpath("config") .. "/undo"
	if vim.fn.isdirectory(undodir) == 0 then
		vim.fn.mkdir(undodir, "p")
	end
	vim.opt.undodir = undodir
	vim.opt.undofile = true
end
