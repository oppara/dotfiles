
vim.api.nvim_create_augroup('vimrc-cursorline', {})
vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter'}, {
    group = 'vimrc-cursorline',
    pattern = {'*'},
    command = [[setlocal cursorline]]
})
vim.api.nvim_create_autocmd({'WinLeave'}, {
    group = 'vimrc-cursorline',
    pattern = {'*'},
    command = [[setlocal nocursorline]]
})




vim.cmd([[


augroup vimrc-avoid-jis
  autocmd!

  " 日本語を含まない場合にJISと解釈されるのを防ぐ
  autocmd BufReadPost *
        \   if &modifiable && !search('[^\x00-\x7F]', 'cnw') && &filetype != 'svn'
        \ |   setlocal fileencoding=
        \ | endif
augroup END


" Automatic rename of tmux window
" if exists('$TMUX') && !exists('$NORENAME')
if exists('$TMUX')
" if &term =~ "screen"
  augroup vimrc-screen
    autocmd!
    autocmd BufEnter * call system("tmux rename-window " . "'[" . expand("%:t") . "]'")
    autocmd VimLeave * call system("tmux set-window automatic-rename on")
    autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  augroup END
end


augroup vimrc-view
  autocmd!
  " 状態の保存と復元
  " http://vim-users.jp/2009/10/hack84/
  autocmd BufLeave * if expand('%') !=# '' && &buftype ==# '' | mkview | endif
  autocmd BufReadPost * if !exists('b:view_loaded') &&
        \  expand('%') !=# '' && &buftype ==# ''
        \  | silent! loadview
        \  | let b:view_loaded = 1
        \  | endif
  autocmd VimLeave * call map(split(glob(&viewdir . '/*'), "\n"), 'delete(v:val)')

augroup END

augroup vimrc-lcd
  autocmd!

  function! s:lcd()
    if &l:buftype !=# '' && &l:buftype !=# 'help' ||
    \   0 <= index(['vimfiler'], &l:filetype)
      unlet! b:lcd
      return
    endif

    if exists('b:lcd') &&
    \  (b:lcd ==# '' || getcwd() =~# '^\V' . escape(b:lcd, '\') . '\$')
      return
    endif

    let path = s:lcd_path()
    if isdirectory(path)
      lcd `=path`
      let b:lcd = getcwd()
    endif
  endfunction

  function! s:lcd_path()
    let path = ''
    let simple = expand('%:p:h')

    if &l:buftype ==# 'help'
      return simple
    endif

    if path !=# ''
      return path
    endif

    return simple
  endfunction

  " 現在編集中のバッファのディレクトリに移動する
  autocmd BufReadPre,BufFilePre * unlet! b:lcd
  autocmd BufReadPost,BufFilePost,BufEnter * call s:lcd()
augroup END

augroup vimrc-misc
  autocmd!
  " 最後に編集した位置へカーソルを移動
  autocmd BufReadPost
        \ * if line("'\"") && line("'\"") <= line('$')
        \ |   execute 'normal! g`"'
        \ | endif

  " 辞書設定
  autocmd FileType
        \ * if filereadable(expand('~/.vim/dict/' . &l:filetype . '.dict'))
        \ |   let &l:dict = '~/.vim/dict/' . &l:filetype . '.dict'
        \ | endif

  " ファイルタイプ再設定
  autocmd BufWritePost
        \ * if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif
augroup END


]])



-- Autocmd:  "{{{1

--[[
augroup vimrc-quicklook-fix  "{{{2
  autocmd!
  " http://d.hatena.ne.jp/uasi/20110523/1306079612
  autocmd BufWritePost * call s:set_utf8_xattr(expand("<afile>"))

  function! s:set_utf8_xattr(file)
    let isutf8 = &fileencoding == "utf-8" || ( &fileencoding == "" && &encoding == "utf-8")
    if g:is_mac && isutf8
      call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
    endif
  endfunction
augroup END



augroup vimrc-quickfix  "{{{2
  autocmd!
  " Quickfixを自動で閉じる
  " http://hail2u.net/blog/software/vim-auto-close-quickfix-window.html
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif

  " Quickfixを自動で開く
  " http://www.sopht.jp/blog/index.php?/archives/458-Quickfix-utility-for-Vim.html
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow

  autocmd QuickfixCmdPost grep,grepadd,vimgrep copen
  autocmd QuickfixCmdPost make call s:do_post_quickfix_cmd()

  function! s:do_post_quickfix_cmd()
    if len(getqflist()) > 0
      cw
    else
      cclose
    endif
  endfunction
augroup END


]]

