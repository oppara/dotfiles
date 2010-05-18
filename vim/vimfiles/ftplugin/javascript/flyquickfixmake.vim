if exists("b:did_ftplugin_javascript_flyquickfixmake")
    finish
endif
let b:did_ftplugin_javascript_flyquickfixmake = 1

if ( has('win32') )
    setlocal makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ $VIM/.jsl.conf\ -process\ % 
else
    setlocal makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ '$HOME/.vim/tools/jsl.conf'\ -process\ % 
endif


setlocal errorformat=%f(%l):\ %m

autocmd BufWritePost *.js silent! make! | redraw!
" autocmd BufWritePost *.js silent! make!
