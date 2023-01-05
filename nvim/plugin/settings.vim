" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50
set ruler
set number
set showcmd
set relativenumber

" netrw
let g:netrw_liststyle=3

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
set colorcolumn=+1

" Tags
set tags=.tags,.tags_dependencies

" Disable mouse to make copying easier
if has('mouse')
  set mouse=
endif

" Colors & highlighting
syntax on
color dracula
set hlsearch
if has('termguicolors')
  set termguicolors
endif

" vim-json
let g:vim_json_syntax_conceal = 0

" ALE
let g:ale_set_loclist = 0
let g:ale_lint_delay = 10
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_virtualtext_prefix = '[%linter%]% code%: '
let g:ale_echo_msg_format = '[%linter%]% code%: %s'
let g:ale_sign_error = '!'
let g:ale_sign_warning = '!'

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
  set grepprg=ag\ --nogroup\ --nocolor\ -U\ --hidden\ --ignore=.git\ --ignore=log/\ --ignore=tmp/\ --ignore=build/\ --ignore=coverage/\ --ignore=public/bundles/\ --ignore=public/assets/

  " Use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag %s --hidden -U --ignore=.git --nocolor -l -g ""'
  let g:ctrlp_use_caching = 0
endif

" Signify
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_change = '~'

let mapleader='\'

" Grep and automatically open quickfix window ("window grep")
command! -nargs=+ -complete=file -bar Wgrep silent grep! <args>|cwindow
command! -nargs=+ -complete=file -bar Wgrepadd silent grepadd! <args>|cwindow
cnoreabbrev Wgr Wgrep
cnoreabbrev Wgra Wgrepadd

" Mappings
nnoremap <leader>ss :Wgrep<SPACE>
nnoremap <leader>Ss :Wgrepadd<SPACE>
nnoremap <leader>sw :Wgrep <C-r><C-w><CR>
nnoremap <leader>sW :Wgrep -i <C-r><C-w><CR>
nnoremap <leader>Sw :Wgrepadd <C-r><C-w><CR>
nnoremap <leader>SW :Wgrepadd -i <C-r><C-w><CR>
nnoremap <C-M-p> :CtrlPTag<CR>
nnoremap <leader>d :ALEGoToDefinition<CR>
nnoremap <leader>c :let @/ = ""<CR>

" CTRL-<navigation> to move windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
