vim.api.nvim_create_augroup('full-width-whitespace', {})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter' }, {
  group = 'full-width-whitespace',
  pattern = { '*' },
  command = [[call matchadd('FullWidthWhitespace', '[\u200B\u3000]')]],
})
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  group = 'full-width-whitespace',
  pattern = { '*' },
  command = [[highlight default FullWidthWhitespace ctermbg=202 ctermfg=202 guibg=salmon]],
})

vim.cmd('colorscheme kanagawa')
vim.cmd('colorscheme wombat_classic')
