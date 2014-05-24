if exists("b:did_ftplugin_perl_config")
    finish
endif
let b:did_ftplugin_perl_config = 1


setlocal dictionary+=~/.vim/dict/perl_functions.dict
setlocal complete+=k
setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4

noremap <buffer> <leader>t <esc>:!prv -lv t/%<cr>
noremap <buffer> <leader>T <esc>:!prv -lv t/% \| less<cr>


