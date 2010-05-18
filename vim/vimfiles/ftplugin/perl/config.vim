if exists("b:did_ftplugin_perl_config")
    finish
endif
let b:did_ftplugin_perl_config = 1

setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

setlocal dictionary+=~/.vim/dict/perl_functions.dict
setlocal complete+=k

noremap <buffer> <leader>t <esc>:!prv -lv t/%<cr>
noremap <buffer> <leader>T <esc>:!prv -lv t/% \| less<cr>


