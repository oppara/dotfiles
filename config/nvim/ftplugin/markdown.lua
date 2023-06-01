vim.cmd([[
    set commentstring=<\!--\ %s\ -->
]])


-- augroup vimrc-ft-markdown
--   autocmd!
--   " surround.vim
--   autocmd FileType markdown let b:surround_{char2nr('l')} = "[](\r)"
-- augroup END
