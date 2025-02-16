vim.cmd([[
    set commentstring=<\!--\ %s\ -->

    augroup vimrc-ft-markdown
      autocmd!
      autocmd FileType markdown setlocal expandtab softtabstop=2 shiftwidth=2
      " surround.vim
      autocmd FileType markdown let b:surround_{char2nr('l')} = "[](\r)"
    augroup END

]])


