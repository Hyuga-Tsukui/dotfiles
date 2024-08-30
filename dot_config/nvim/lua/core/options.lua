local opt = vim.opt

-- line numbers
-- opt.number = true
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
-- opt.incsearch = true
-- opt.hlsearch = true

-- cursorline
opt.cursorline = true

-- appearence
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.title = true

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- log
opt.history = 500
opt.swapfile = false
opt.updatetime = 500

opt.iskeyword:append("-")

local undodir = vim.fn.stdpath("config") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undofile = true
