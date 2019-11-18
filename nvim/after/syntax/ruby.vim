unlet b:current_syntax

syn include @SQL syntax/sql.vim
syn region sqlHeredoc start=/\v\<\<[-~]SQL/ end=/\vSQL/ keepend contains=@SQL

syn include @HTML syntax/eruby.vim
syn region htmlHeredoc start=/\v\<\<[-~]HTML/ end=/\vHTML/ keepend contains=@HTML

syn include @XML syntax/xml.vim
syn region xmlHeredoc start=/\v\<\<[-~]XML/ end=/\vXML/ keepend contains=@XML

let b:current_syntax = "ruby"
