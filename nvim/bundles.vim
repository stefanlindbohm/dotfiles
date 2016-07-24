call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim'

Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plug 'tpope/vim-fugitive' " git integration
Plug 'mhinz/vim-signify' " git info in the gutter

" Languages
Plug 'JSON.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'ap/vim-css-color' " Color highlighting for relevant filetypes
Plug 'othree/yajs.vim'

" Frameworks & tools
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'


call plug#end()
