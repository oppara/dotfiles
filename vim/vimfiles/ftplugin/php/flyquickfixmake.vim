if exists("b:did_ftplugin_php_flyquickfixmake")
    finish
endif
let b:did_ftplugin_php_flyquickfixmake = 1

compiler php
let g:php_flyquickfixmake = 1
autocmd BufWritePost * silent make % | redraw!
