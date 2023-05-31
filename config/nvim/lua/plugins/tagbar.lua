
vim.cmd([[

noremap <silent> <leader>tl :TagbarOpenAutoClose<cr>

let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['+', '-']

" https://github.com/majutsushi/tagbar/wiki
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:H1',
        \ 'i:H2',
        \ 'k:H3',
        \ 'l:H4'
    \ ]
\ }

let g:tagbar_type_php = {
    \ 'kinds' : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions:1:0',
        \ 'f:functions',
    \ ],
\ }

let g:tagbar_type_javascript = {
    \ 'kinds' : [
        \ 'I:interfaces',
        \ 'C:classes',
        \ 'D:constant definitions:1:0',
        \ 'F:functions',
        \ 'V:variables',
    \ ],
\ }


]])



