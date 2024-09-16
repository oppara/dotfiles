
vim.cmd([[

noremap <silent> <leader>tl :TagbarOpenAutoClose<cr>
"
let g:tagbar_position = 'topleft vertical'
let g:tagbar_width = max([25, winwidth(0) / 5])

let g:tagbar_sort = 0
let g:tagbar_compact = 2
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['+', '-']
]])
