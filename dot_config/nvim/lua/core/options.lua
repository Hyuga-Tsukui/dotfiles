local opt = vim.opt

opt.cmdheight = 2

-- clipboard
opt.clipboard:append("unnamedplus")
opt.scrolloff = 8

opt.incsearch = true
opt.hlsearch = true

-- vscodeでnvimを使う場合に意図しない動作を起こすので、vscodeの場合は以下の設定を行わない
if not vim.g.vscode then
    -- appearance
    opt.guicursor = ""
    opt.laststatus = 0 -- status-line系のpluginへの切り替え時のちらつきを防ぐためにデフォルトは表示しないようにする.
    -- line numbers
    opt.nu = false
    opt.relativenumber = false
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

    -- appearance
    opt.termguicolors = true
    opt.background = "dark"
    opt.signcolumn = "yes"
    opt.title = true

    opt.winblend = 0 -- ウィンドウの不透明度
    opt.pumblend = 0 -- ポップアップメニューの不透明度

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

    local undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")
    if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir, "p")
    end
    opt.undodir = undodir
    opt.undofile = true
end
