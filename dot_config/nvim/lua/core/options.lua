local opt = vim.opt

vim.opt.cmdheight = 2

vim.cmd([[
  autocmd FileType qf setlocal wrap
]])

-- clipboard
opt.clipboard:append("unnamedplus")
opt.scrolloff = 8

vim.opt.incsearch = true
vim.opt.hlsearch = true

if not vim.g.vscode then
    -- appearance
    opt.guicursor = ""
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
    vim.opt.undodir = undodir
    vim.opt.undofile = true
end
