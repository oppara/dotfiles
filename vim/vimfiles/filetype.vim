
if exists("did_load_filetypes")
  finish
endif

" http://plasticboy.com/markdown-vim-mode/"
augroup markdown
  autocmd! BufRead,BufNewFile *.mkd   setfiletype mkd
augroup END

augroup svk
autocmd! BufNewFile,BufRead svk-commit*.tmp setfiletype svk |setlocal fileencoding=utf-8
augroup END

