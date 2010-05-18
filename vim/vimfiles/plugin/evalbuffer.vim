"========================================================================
" evalbuffer.vim - Evaluate selection and open output as preview window.
"========================================================================
" Author:  Yuki <paselan at Gmail.com>
" Version: 1.0
" Date:    May 18, 2008
" License: MIT License
" URL:     http://eureka.pasela.org/
"------------------------------------------------------------------------
" Description:
"   Evaluate selection by external command related to filetype and open
"   output as preview window.
"
" Installation:
"   Put this file in your plugin directory.
"
" Usage:
"   Select string and run EvalBuffer command. Then the output is
"   displayed in the preview window.
"
"   The external command used for execution becoms filetype.
"   You can change it by below options.
"
"   To keep more convenient, you can add mappings as follows.
"
"     Evaluate selection:
"       vmap <silent> <F10> :EvalBuffer<CR>
"
"     Evaluate buffer:
"       nmap <silent> <F10> mzggVG<F10>`z
"
"     Close preview window:
"       map  <silent> <S-F10> :pc<CR>
"
"   NOTE: evalbuffer.vim does not provide any mappings by default. These
"         have to set in the user's .vimrc if you want to use mappings.
"
" Options:
"   g:EvalBuffer_Command_Map:
"     This is a dictionary. Each key corresponds to a filetype.
"     Each value is a external command name.
"
" Thanks:
"   vimtip #1244
"
" Changelog:
"   1.0:
"     - First release.
"========================================================================


" filetype to command map
let s:EvalBuffer_Command_Map = {
\   'perl'   : 'perl',
\   'php'    : 'php',
\   'python' : 'python',
\   'ruby'   : 'ruby',
\   'eruby'  : 'eruby'
\ }

if exists('g:EvalBuffer_Command_Map')
    let s:EvalBuffer_Command_Map = extend(s:EvalBuffer_Command_Map, g:EvalBuffer_Command_Map)
endif

" preview interpreter's output(Tip #1244)
function! EvalBuffer() range
    " get command from filetype
    if (&ft != '' && has_key(s:EvalBuffer_Command_Map, &ft))
        let cmd = s:EvalBuffer_Command_Map[&ft]
    else
"        echoerr 'The external command to this filetype(' . &ft . ') is not defined.'
        echohl WarningMsg | echo 'The external command to this filetype(' . &ft . ') is not defined.' | echohl none
        return -1
    endif

    let src = tempname()
    let dst = 'EvalOutput'

    " PHP support
    if (&ft == 'php')
        let str = getline(a:firstline, a:lastline)
        if match(str, '<?php') == -1
            silent execute ':redir! > ' . src
            silent echon "<?php\n"
            redir END"
        endif
    endif

    " put current buffer's content in a temp file
    silent execute ': ' . a:firstline . ',' . a:lastline . 'w! >> ' . src
    " open the preview window
    silent execute ':pedit! ' . dst
    " change to preview window
    wincmd P
    " set options
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal syntax=none
    setlocal bufhidden=delete

    " replace current buffer with php's output
    silent execute ':%!' . cmd . ' ' . src . ' 2>&1 '

    " change back to the source buffer
    wincmd p
endfunction

command! -nargs=0 -range=% EvalBuffer <line1>,<line2>call EvalBuffer()


" vim:set ft=vim ts=4 sw=4 sts=4 et:
