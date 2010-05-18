if exists("b:did_ftplugin_php_config")
    finish
endif

setlocal runtimepath+=$HOME/.vim/php
setlocal keywordprg=:help
" nnoremap <buffer> <silent> K  :<C-u>help <C-r><C-w><Return>

let b:did_ftplugin_php_config = 1

let g:php_man_url = 'http://jp.php.net/manual-lookup.php?lang=ja&pattern='

setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

setlocal commentstring=//%s
" setlocal foldmethod=syntax

" :h php
let php_sql_query=1
let php_htmlInStrings=1
        


abbreviate a( array(
abbreviate d( debug(

setlocal dictionary=~/.vim/dict/PHP.dict
setlocal tags+=~/.vim/dict/pear.tags

function! s:PhpMan()
  let b:word = expand( "<cword>:p" )
  let s:url = g:php_man_url.b:word
"   echo $url
  silent exec '!open -a safari "' . s:url . '"'
endfunction
nnoremap <buffer><silent> <leader>h :call <SID>PhpMan()<cr>

"--------------------------------------------------------------
" PDV - phpDocumentor for Vim :
" http://www.vim.org/scripts/script.php?script_id=1355
" inoremap <leader>d <ESC>:call PhpDocSingle()<CR>i 
nnoremap <buffer><leader>d :call PhpDocSingle()<cr>bcw
vnoremap <buffer><leader>d :call PhpDocRange()<cr>

let g:pdv_cfg_Package = ""
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_Version = "$id$"
" let g:pdv_cfg_Author = "Nobuo OOHARA " . g:opp_email
let g:pdv_cfg_Author = "Nobuo OOHARA <ohara@n3.co.jp>" 
let g:pdv_cfg_php4guessval = 'private'
let g:pdv_re_bool = "\(true\|false\)"


"--------------------------------------------------------------
" surround.vim
"
if exists('g:loaded_surround')
  let b:surround_{char2nr('G')} = "__( '\r', true )"
  let b:surround_{char2nr('g')} = "__( '\r' );"
  let b:surround_{char2nr('e')} = "<?php echo \r ?>"
  let b:surround_{char2nr('p')} = "<?php \r ?>"
  let b:surround_104 = 'h( \r )' "104 = h
  nmap g' cs'g
  nmap g" cs"g
  nmap G' cs'G
  nmap G" cs"G
endif

    
