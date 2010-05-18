
if exists("g:opp_save_as")
    finish
endif
let g:opp_save_as = 1

"-----------------------------------------------------------------------------
" function SaveAs
"
"���ݒ�B
"    Windows �̂����艮�z�z�ł͐ݒ肷����̂͂���܂���B
"
"    UNIX/Linux �̏ꍇ fileencodings (�����`) ��K�؂ɐݒ肵�Ă��������B
"    �ȒP�ɂ́A$HOME/.vimrc �̒��ɁA
"
"set fileencodings=iso-2022-jp,euc-jp,utf-8,cp932
"
"    �Ƃ��ł����C�ł��B( �ϊ��ł͂Ȃ��A�ǂݍ��݂ɕK�v )
"-----------------------------------------------------------------------------
" Usage:
" COMMAND                 CHARSET                    NEWLINE
" :Saveas                 �V�X�e���f�t�H���g         �V�X�e���f�t�H���g
" :Saveas win             cp932                      cr lf
" :Saveas dos             cp932                      cr lf
" :Saveas mac             cp932                      cr
" :Saveas unix            euc-jp or euc-jisx0213     lf
" :Saveas linux           euc-jp or euc-jisx0213     lf

" :Saveas sjis cr lf      cp932                      cr lf
" :Saveas sjis cr         cp932                      cr
" :Saveas sjis            cp932                      �V�X�e���f�t�H���g
" :Saveas euc lf          euc-jp or euc-jisx0213     lf
" :Saveas euc             euc-jp or euc-jisx0213     �V�X�e���f�t�H���g
" :Saveas jis lf          iso-2022-jp �Ȃ�           lf
" :Saveas utf8 cr lf      utf-8                      cr lf
" :Saveas lf              �V�X�e���f�t�H���g         lf
" �ȂǁB
" (1) �����̑啶���������͖�������B
" (2) jis �� euc �́A�V������ł���Ȃ�Ɉ����B( &fencs �ˑ� )
" (3) sjis,jis,euc,utf8 �ȊO�́Aiconv �ŗL���ȕ������n�����ƁB
"-----------------------------------------------------------------------------

command! -nargs=? Saveas :call SaveAs(<q-args>)

"-----------------------------------------------------------------------------
function! SaveAs(...)
    " ���������ł� <q-args> �� "" ��n���Ă���B
    let cs = tolower(a:1)

    "ALIAS
    if cs =~? '\<\(win\|dos\)\>'
        let cs = "sjis crlf"
    elseif cs =~? '\<mac\>'
        let cs = "sjis cr"
    elseif cs =~? '\<\(unix\|linux\)\>'
        let cs = "euc lf"
    endif

    "NEWLINE
    if cs =~? '\<cr\s*lf\>'
        setlocal ff=dos
        let cs = substitute(cs,'\<cr\s*lf\>','','')
        let ff = "cr lf"
    elseif cs =~? '\<cr\>'
        setlocal ff=mac
        let cs = substitute(cs,'\<cr\>','','')
        let ff = "cr"
    elseif cs=~? '\<lf\>'
        setlocal ff=unix
        let cs = substitute(cs,'\<lf\>','','')
        let ff = "lf"
    else
        setlocal ff&
        if &ff ==? "dos"
            let ff="cr lf"
        elseif &ff ==? "mac"
            let ff="cr"
        else
            let ff="lf"
        endif
    endif
    let cs = substitute(cs, '\s\+',"","g")
    let fencs = ',' . &encoding . ',' . &fencs . ','

    "CHARSET
    if cs ==? 'sjis'
        setlocal fenc=cp932
    elseif cs ==? 'jis'
        if fencs =~? '\<iso-2022-jp-\d\+'
            let jis = matchstr(fencs, '\<iso-2022-jp-\d\+')
        else
            let jis = 'iso-2022-jp'
        endif
        exe 'setlocal fenc=' . jis
    elseif cs =~? '^\(euc\|euc-jp\)$'
        if fencs =~? '\<euc-jisx0213'
            let euc = 'euc-jisx0213'
        else
            let euc = 'euc-jp'
        endif
        exe 'setlocal fenc=' . euc
    elseif cs ==? 'utf8'
        setlocal fenc=utf-8
    elseif cs =~ '[^ ,]\+'
        let cs = matchstr(tolower(cs), '[^ ,]\+')
        if stridx(fencs, ',' . cs . ',') == -1
            let mes = cs . " �� encoding �Ɉ�v���܂���B\n" .
                    \ cs . " �� fileencodings �ɂ��܂܂�Ă��܂���B\n" .
                    \ "�ϊ����܂��� ? (y/n):"
            redraw!
            let rt=input(mes,"")
            if rt !=? 'y' | return | endif
            echo " "
        endif
        exe 'setlocal fenc=' . cs
    else
        setlocal fenc=
    endif

    "WRITE
    let v:errmsg=""
    redir @z
    silent write
    redir END
    if v:errmsg==""
        "redraw
        echo @z . " " . (&fenc!="" ? &fenc : &enc) . " " . ff
    else
        setlocal fenc=
        setlocal ff&
    endif
endfunction

