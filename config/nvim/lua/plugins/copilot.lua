vim.g.copilot_no_maps = true

vim.g.copilot_filetypes = {
  markdown = true;
  gitcommit = true;
}

local keyset = vim.keymap.set
keyset('i', '<C-k>', '<Plug>(copilot-previous)')
keyset('i', '<C-o>', '<Plug>(copilot-dismiss)')


keyset(
'i',
'<C-g>',
'copilot#Accept("<CR>")',
{ silent = true, expr = true, script = true, replace_keycodes = false }
)
