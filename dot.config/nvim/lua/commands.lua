
vim.cmd([[


" :SetMarkdownTrailingSpaceHighlight "{{{2
function! s:set_markdown_trailing_space_highlight()
  match Underlined /\s\{2}$/
  highlight Underlined ctermbg=black ctermfg=red guibg=black guifg=red
endfunction
command! -range=0 SetMarkdownTrailingSpaceHighlight call s:set_markdown_trailing_space_highlight()

" EchoSyntax  "{{{2
" カーソル位置のsyntax要素の名前を表示
command! -nargs=0 EchoSyntax echo synIDattr(synID(line("."), col("."), 1), "name")

" :Scratch "{{{2
command! -nargs=0 Scratch new | setlocal bt=nofile noswf | let b:cmdex_scratch = 1
function! s:CheckScratchWritten()
  if &buftype ==# 'nofile' && expand('%').'x' !=# 'x' && exists('b:cmdex_scratch') && b:cmdex_scratch == 1
    setlocal buftype= swapfile
    unlet b:cmdex_scratch
  endif
endfunction
augroup CmdexScratch
  autocmd!
  autocmd BufWritePost * call <SID>CheckScratchWritten()
augroup END


" 選択範囲をパターンにして検索 "{{{2
" @TODO visual star
" http://d.hatena.ne.jp/ns9tks/20080717/1216310786
function! s:SetSearch(text, is_word)
  let pattern = substitute(escape(a:text, '\'), '\n', '\\n', 'g')
  if a:is_word
    let @/ = '\C\V\<' . pattern . '\>'
  else
    let @/ = '\C\V' . pattern
  endif
  call histadd('/', pattern)
  set hlsearch
endfunction
vnoremap <silent> *  :<C-u>call <SID>SetSearch(<SID>SelectedText(), 1)<cr>
vnoremap <silent> g* :<C-u>call <SID>SetSearch(<SID>SelectedText(), 0)<cr>

" 指定桁のセパレータコメントを挿入 "{{{2
" http://d.hatena.ne.jp/ns9tks/20081127/1227757541
function! <SID>GetSeparatorLineString(pre, char, post, col_len)
  let chars_len =  a:col_len - (virtcol(".") - 1) - strlen(a:pre) - strlen(a:post)
  if chars_len < 0 || strlen(a:char) == 0
    return ''
  endif
  return  a:pre . repeat(a:char, chars_len / strlen(a:char)) . a:post
endfunction
inoremap <expr> <C-\>   <Nop>
inoremap <expr> <C-\>// <SID>GetSeparatorLineString('//', '/', ''        , 78)
inoremap <expr> <C-\>/- <SID>GetSeparatorLineString('//', '-', ''        , 78)
inoremap <expr> <C-\>/. <SID>GetSeparatorLineString('//', '.', ''        , 78)
inoremap <expr> <C-\>/* <SID>GetSeparatorLineString('/*', '*', '*/'      , 78)
inoremap <expr> <C-\>"" <SID>GetSeparatorLineString('"' , '"', ''        , 78)
inoremap <expr> <C-\>-- <SID>GetSeparatorLineString('-' , '-', ''        , 78)
inoremap <expr> <C-\>== <SID>GetSeparatorLineString('=' , '=', ''        , 78)
inoremap <expr> <C-\>"- <SID>GetSeparatorLineString('"' , '-', ''        , 78)
inoremap <expr> <C-\>". <SID>GetSeparatorLineString('"' , '.', ''        , 78)
inoremap <expr> <C-\>## <SID>GetSeparatorLineString('#' , '#', ''        , 78)
inoremap <expr> <C-\>#- <SID>GetSeparatorLineString('#' , '-', ''        , 78)
inoremap <expr> <C-\>#. <SID>GetSeparatorLineString('#' , '.', ''        , 78)
inoremap <expr> <C-\>;; <SID>GetSeparatorLineString(';' , ';', ''        , 78)
inoremap <expr> <C-\>(* <SID>GetSeparatorLineString('(' , '*', ')'       , 78)
inoremap <expr> <C-\>={ <SID>GetSeparatorLineString('=' , '=', ' {{'.'{1', 78)
inoremap <expr> <C-\>=} <SID>GetSeparatorLineString('=' , '=', ' }}'.'}1', 78)
inoremap <expr> <C-\>-{ <SID>GetSeparatorLineString('-' , '-', ' {{'.'{1', 78)
inoremap <expr> <C-\>-} <SID>GetSeparatorLineString('-' , '-', ' }}'.'}1', 78)


]])
