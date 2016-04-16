" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50
set ruler
set number
set showcmd

" Split settings
set splitright
set splitbelow

" Highlight invisible characters
set list
set listchars=tab:→\ ,eol:¬,nbsp:•,space:.

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2

" Disable mouse to make copying easier
if has('mouse')
  set mouse=
endif

" Colors & highlighting
syntax on
color dracula
set hlsearch

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
augroup lastPosition
au!
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif
augroup END

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ -U

  " Use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag %s -U -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

let mapleader='\'

" Grep and automatically open quickfix window ("window grep")
command -nargs=+ -complete=file -bar Wgrep silent grep! <args>|cwindow|redraw!
command -nargs=+ -complete=file -bar Wgrepadd silent grepadd! <args>|cwindow|redraw!
cnoreabbrev Wgr Wgrep
cnoreabbrev Wgra Wgrepadd

" Mappings
nnoremap <leader>ss :Wgrep<SPACE>
nnoremap <leader>Ss :Wgrepadd<SPACE>
nnoremap <leader>sw :Wgrep <C-r><C-w><CR>
nnoremap <leader>sW :Wgrep -i <C-r><C-w><CR>
nnoremap <leader>Sw :Wgrepadd <C-r><C-w><CR>
nnoremap <leader>SW :Wgrepadd -i <C-r><C-w><CR>
