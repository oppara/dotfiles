-- https://github.com/iamcco/markdown-preview.nvim

vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>r', ':<C-u>MarkdownPreview<CR>', {noremap = true, silent = true})
vim.g.mkdp_echo_preview_url = 1

