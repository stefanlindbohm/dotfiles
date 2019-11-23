call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim'

Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plug 'tpope/vim-fugitive' " git integration
Plug 'mhinz/vim-signify' " git info in the gutter
Plug 'vim-syntastic/syntastic' " syntax checking
Plug 'tpope/vim-commentary' " comment stuff in & out
Plug 'tpope/vim-repeat' " repeat for plugins

" Text objects
Plug 'michaeljsmith/vim-indent-object' " indentation level
Plug 'tpope/vim-surround' " surrounding

" Languages
Plug 'elzr/vim-json'
Plug 'vim-ruby/vim-ruby'
Plug 'ap/vim-css-color' " Color highlighting for relevant filetypes
Plug 'pangloss/vim-javascript'
Plug 'keith/swift.vim'

" Frameworks & tools
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

call plug#end()
