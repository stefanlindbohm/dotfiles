" List characters
autocmd ColorScheme * hi NonText ctermfg=246 ctermbg=NONE cterm=NONE guifg=#5c5e65 guibg=NONE gui=NONE
autocmd ColorScheme * hi SpecialKey ctermfg=246 ctermbg=NONE cterm=NONE guifg=#4b4c55 guibg=NONE gui=NONE

" Diffs
autocmd ColorScheme * hi DiffAdd ctermfg=64 ctermbg=NONE guifg=#50fa7b guibg=NONE
autocmd ColorScheme * hi DiffChange ctermfg=11 ctermbg=NONE guifg=#f1fa8c guibg=NONE
autocmd ColorScheme * hi DiffDelete ctermfg=9 ctermbg=NONE guifg=#ff6e67 guibg=NONE
autocmd ColorScheme * hi diffAdded ctermfg=64 ctermbg=NONE guifg=#50fa7b guibg=NONE
autocmd ColorScheme * hi diffChanged ctermfg=11 ctermbg=NONE guifg=#f1fa8c guibg=NONE
autocmd ColorScheme * hi diffRemoved ctermfg=9 ctermbg=NONE guifg=#ff6e67 guibg=NONE
autocmd ColorScheme * hi link diffNoEOL Error
autocmd ColorScheme * hi link DiffLine Identifier
autocmd ColorScheme * hi link diffSubname Constant

" Signify
autocmd ColorScheme * hi SignColumn ctermbg=236 guibg=#3d3f49
autocmd ColorScheme * hi SignifySignAdd cterm=bold ctermfg=64 ctermbg=236 gui=bold guifg=#50fa7b guibg=#3d3f49
autocmd ColorScheme * hi SignifySignChange cterm=bold ctermfg=11 ctermbg=236 guifg=#f1fa8c guibg=#3d3f49
autocmd ColorScheme * hi SignifySignDelete cterm=bold ctermfg=9 ctermbg=236 gui=bold guifg=#ff6e67 guibg=#3d3f49

" Syntastic
autocmd ColorScheme * hi SyntasticWarningSign cterm=bold ctermfg=11 ctermbg=236 guifg=#3d3f49 guibg=#f1fa8c
autocmd ColorScheme * hi SyntasticErrorSign  cterm=bold ctermfg=9 ctermbg=236 gui=bold guifg=#3d3f49 guibg=#ff6e67
