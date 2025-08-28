local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>tl', ':TagbarOpenAutoClose<cr>', opts)

vim.g.tagbar_position = 'topleft vertical'
vim.g.tagbar_sort = 0
vim.g.tagbar_compact = 2
vim.g.tagbar_indent = 2
vim.g.tagbar_wrap = 1
vim.g.tagbar_iconchars = { '+', '-' }
vim.g.tagbar_width = math.max(40, vim.fn.winwidth(0) / 5)

-- TagbarGetTypeConfig filetype

vim.g.tagbar_type_php = {
  kinds = {
    'n:namespaces:0:0',
    'a:use aliases:1:0',
    'd:constant definitions:0:0',
    'i:interfaces',
    't:traits',
    'c:classes',
    'f:functions',
  },
  sort = 0,
}

vim.g.tagbar_type_markdown = {
  kinds = {
    'c:chapter',
    's:section',
    'S:subsection',
    't:subsubsection',
    'T:l3subsection',
    'u:l4subsection',
  },
  sort = 0,
}
