if exists("b:did_ftplugin_perl_flyquickfixmake")
    finish
endif
let b:did_ftplugin_perl_flyquickfixmake = 1

compiler perl
autocmd BufWritePost * silent! make % | redraw!
" setlocal makeprg=perl\ -c\ %
" setlocal errorformat=%f(%l):\ %m
" autocmd BufWritePost * silent! make!  | redraw!
