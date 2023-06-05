-- https://github.com/iamcco/markdown-preview.nvim

local keymap = vim.api.nvim_buf_set_keymap
keymap('n', '<Leader>r', ':<C-u>MarkdownPreview<CR>', {noremap = true, silent = true})

vim.g.mkdp_echo_preview_url = 1

