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

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function()
    vim.cmd.colorscheme('kanagawa')
    require('lualine').setup({
      options = { theme = 'everforest' },
    })
  end,
})
