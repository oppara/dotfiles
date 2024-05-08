vim.g.copilot_no_tab_map = true

vim.g.copilot_filetypes = {
  markdown = true;
  gitcommit = true;
}

local keymap = vim.keymap.set
keymap('i', '<C-k>', '<Plug>(copilot-previous)')
keymap('i', '<C-o>', '<Plug>(copilot-dismiss)')

