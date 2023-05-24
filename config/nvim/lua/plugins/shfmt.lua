print('shfmt')


vim.cmd([[
let g:shfmt_extra_args = '-i 2 -ci -bn -s'

augroup my-shfmt
  autocmd!
  autocmd FileType sh nnoremap <silent><buffer><leader>ti :Shfmt<cr>
augroup END
]])
