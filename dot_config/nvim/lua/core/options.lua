local opt = vim.opt
opt.clipboard:append('unnamedplus') -- share yanked text with system clipboard

-- appearance settings
opt.nu = true
opt.relativenumber = true

-- search settings.
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.backspace = 'indent,eol,start'
opt.scrolloff = 8

-- completion settings
opt.iskeyword:append('-')

-- appearance settings
-- opt.guicursor = ""
opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20'
opt.laststatus = 0 -- status-line系のpluginへの切り替え時のちらつきを防ぐためにデフォルトは表示しないようにする.
opt.cmdheight = 0
opt.conceallevel = 2
opt.wrap = false
opt.cursorline = true
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'
opt.title = true
opt.winblend = 0 -- ウィンドウの不透明度
opt.pumblend = 0 -- ポップアップメニューの不透明度
opt.splitright = true
opt.splitbelow = true

-- log settings
opt.history = 500
opt.updatetime = 50

-- backup settings
opt.swapfile = false
opt.backup = false

local undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end
opt.undodir = undodir
opt.undofile = true
