if &filetype ==? 'ruby'
  unlet b:current_syntax

  syn include @SQL syntax/sql.vim
  syn region sqlHeredoc start=/\v\C%(\<\<[-~]SQL)@<=/ end=/\v\C%(SQL)@=/ keepend contains=@SQL

  syn include @HTML syntax/eruby.vim
  syn region htmlHeredoc start=/\v\C%(\<\<[-~]HTML)@<=/ end=/\v\C%(HTML)@=/ keepend contains=@HTML

  syn include @XML syntax/xml.vim
  syn region xmlHeredoc start=/\v\C%(\<\<[-~]XML)@<=/ end=/\v\C(XML)@=/ keepend contains=@XML

  let b:current_syntax = "ruby"
endif
