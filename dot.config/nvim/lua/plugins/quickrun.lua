-- vim.api.nvim_set_keymap('n', '<leader>r', '<plug>(quickrun)', {noremap = false, silent = true})
-- vim.api.nvim_create_augroup('vim-quickrun', {})
-- vim.api.nvim_create_autocmd({'FileType'}, {
    -- group = 'vim-quickrun',
    -- pattern = {'quickrun'},
    -- command = [[nnoremap <silent><buffer>q :quit<CR>]]
-- })


vim.cmd([[

map <Leader>r <plug>(quickrun)

augroup vim-quickrun
  autocmd!
  autocmd FileType quickrun nnoremap <silent><buffer>q :quit<CR>
augroup END

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'outputter/buffer/opener': 'new',
      \ 'outputter/buffer/into': 1,
      \ 'outputter/buffer/close_on_empty': 1,
      \ }

let g:quickrun_config['objc'] = {
      \ 'command': 'cc',
      \ 'exec': ['%c %s -o %s:p:r -framework Foundation', '%s:p:r %a', 'rm -f %s:p:r'],
      \ 'tempfile': '{tempname()}.m',
      \}

]])
