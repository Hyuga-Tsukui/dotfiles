local opt = vim.opt

-- line numbers
opt.number = true

-- tab & indentation
opt.tabstop = 2
opt.shiftwidth = 2
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
