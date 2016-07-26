" Force local eslint from npm. Substitution is hacking away return characters from the shell command.
let b:syntastic_javascript_eslint_exec = substitute(system('PATH=$(npm bin) && which eslint'), '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:syntastic_javascript_checkers = ['eslint']
