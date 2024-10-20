
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>tl', ':TagbarOpenAutoClose<cr>', opts)

vim.g.tagbar_position = 'topleft vertical'
vim.g.tagbar_sort = 0
vim.g.tagbar_compact = 2
vim.g.tagbar_indent = 2
vim.g.tagbar_wrap = 1
vim.g.tagbar_iconchars = {'+', '-'}
vim.g.tagbar_width = math.max(40, vim.fn.winwidth(0) / 5)


