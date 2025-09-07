vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_floating_win_opts = { border = 'single' }
vim.g.git_messenger_popup_content_margins = false

vim.g.git_messenger_no_default_mappings = true
vim.keymap.set('n', '<C-w>m', '<Plug>(git-messenger)', { silent = true })
