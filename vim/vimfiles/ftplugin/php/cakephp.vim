""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cakephp.vim
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "
" " Last Change:  06-Jun-2008.
" " Author:       Kota Sakoda <cohtan AT cpan DOT org>
" " Version:      0.000001
" " Licence:      MIT Licence
" " URL:          http://trac.codecheck.in/
" "
" "-----------------------------------------------------------------------------
" http://blog.cohtan.org/2008/06/cakephpmvccakephpvim.html

function! s:Pluralize(word)
        let s:class = substitute(a:word, "tatus$", "tatuses", "")
        let s:class = substitute(s:class, "x$", "xies", "")
        let s:class = substitute(s:class, "$", "s", "")
  return s:class
endfunction

function! s:Singularize(word)
  return a:word
endfunction

function! s:Ccontroller()
    let s:filename = expand("%")
    let s:base = expand("%:r")
    " echo expand("%")
    " echo expand("%:p")
    " echo expand("%:p:h")
    " echo expand("%:p:t")
    " echo expand("%:r")
    " echo expand("%")
    " echo expand("%:p:e")
    " Viewからの場合
    if s:filename =~ "ctp$"
        let s:filename = substitute(s:filename, "views/", "", "g")
        let s:target_file = substitute(s:filename, "\.ctp", "", "g")
        let s:open_file = "controllers/" . substitute(s:target_file, "/.*", "", "g") . "_controller.php"
        let s:func_name = substitute(s:target_file, ".*/", "", "g")
        execute "open " . s:open_file
        call search('function ' .  s:func_name)
    endif
    " Modelからの場合
    if s:filename =~ "php$"
        let s:app  = substitute(expand("%:p:h"), "models", "", "g")
        let s:class= s:Pluralize(s:base)
        let s:open_file = s:app . 'controllers/' . s:class . "_controller.php"
        echo  s:open_file
        execute ':edit '  . s:open_file
    endif
endfunction

function! s:Cmodel()
    let s:Filename = bufname("")
    " Controllerからの場合
    if s:Filename =~ "controller"
        let s:Filename = substitute(s:Filename, ".*/", "", "g")
        let bclass = substitute(s:Filename, "_controller.php", "", "")

        " とりあえず複数形を単数系に：要改善 TODO
        let bclass = substitute(bclass, "tatuses$", "tatus", "")
        let bclass = substitute(bclass, "ies$", "", "")
        let bclass = substitute(bclass, "s$", "", "")
        execute "open " . "models/" . bclass . ".php"
    endif
    " Viewからの場合
    if s:Filename =~ "ctp$"
        let s:Filename = substitute(s:Filename, "views/", "", "g")
        let s:target_file = substitute(s:Filename, ".*/", "", "g")
        let bclass = substitute(s:target_file, "\.ctp", "", "g")

        " とりあえず複数形を単数系に：要改善 TODO
        let bclass = substitute(bclass, "tatuses$", "tatus", "")
        let bclass = substitute(bclass, "ies$", "", "")
        let bclass = substitute(bclass, "s$", "", "")

        let s:open_file = "models/" . bclass . ".php"
        execute "open " . s:open_file
    endif
endfunction

function! s:Cview()
    let s:Filename = bufname("")
    let s:Filename = substitute(s:Filename, ".*/", "", "g")
    " Controllerからの場合
    if s:Filename =~ "controller"
        let bclass = substitute(s:Filename, "_controller.php", "", "")
        call search('function', 'b')
        execute "normal wvf(hy"
        let s:View = getreg()
        let s:target_file = 'views/' . bclass . '/' . s:View . ".ctp"
        execute "open " . s:target_file
    endif
    " TODO Modelからの場合は無理っちゃ無理か
endfunction


command! -bar -narg=0 Cakecontroller call s:Ccontroller()
command! -bar -narg=0 Cakemodel call s:Cmodel()
command! -bar -narg=0 Cakeview call s:Cview()
