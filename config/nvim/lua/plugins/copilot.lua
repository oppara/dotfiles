
vim.g.copilot_filetypes = {
  markdown = true;
  gitcommit = true;
}

local keyset = vim.keymap.set
keyset('i', '<C-k>', '<Plug>(copilot-previous)')
keyset('i', '<C-o>', '<Plug>(copilot-dismiss)')

