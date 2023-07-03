--local ok, _ = pcall(require, 'iceberg')
--if not ok then
--  return
--end
-- colorscheme -----------------------------------------------------------------
vim.cmd [[
autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none
autocmd ColorScheme * highlight Folded ctermbg=none guibg=none
autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none
autocmd ColorScheme * highlight link FloatBorder NormalFloat
autocmd ColorScheme * highlight Search guifg=#222240 guibg=#77A0E0

colorscheme iceberg

highlight LspReferenceText  ctermbg=8 guibg=#305090
highlight LspReferenceRead  ctermbg=8 guibg=#305090
highlight LspReferenceWrite ctermbg=8 guibg=#305090

highlight link LspFloatWinNormal NormalFloat

highlight FzfLuaNormal guibg=#383850
highlight FzfLuaBorder guibg=#383850 gui=bold
]]
