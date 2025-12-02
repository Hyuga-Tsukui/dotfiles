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
opt.wrapscan = true

opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.backspace = 'indent,eol,start'
opt.scrolloff = 4
opt.sidescrolloff = 4

-- completion settings
opt.iskeyword:append('-')

-- appearance settings
opt.guicursor = 'a:block'
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
opt.history = 500
opt.updatetime = 50
opt.timeoutlen = 500
opt.lazyredraw = true -- 画面の更新を遅延させることでパフォーマンスを向上させる
opt.autoread = true -- ファイルの変更を自動で読み込む
opt.laststatus = 0 -- ステータスラインを常に表示しない

-- backup settings
opt.swapfile = false
opt.backup = false

-- ref: https://zenn.dev/vim_jp/articles/c96e9b1bdb9241
local undodir = vim.env.XDG_STATE_HOME .. '/nvim/undo'
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end
opt.undodir = undodir
opt.undofile = true

opt.jumpoptions = 'stack'

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
