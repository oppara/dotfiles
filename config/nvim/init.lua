vim.scriptencoding = 'utf-8'
vim.language = 'C'

--  global
vim.g.oppara_email = 'oppara <oppara _at_ oppara.tv>'
vim.g.snips_author = vim.g.oppara_email
vim.g.changelog_username = 'oppara'

-- matchparen をやめる
vim.g.loaded_matchparen = 1

vim.cmd([[

let g:is_mac  = has('macunix') || (executable('uname') && system('uname') =~? '^darwin')
let g:is_unix = has('unix') && !g:is_mac
let g:is_win  = has('win32') || has('win64')

]])


-- require
require('encodings')
require('options')
require('plugins')
require('colors')
require('mappings')
require('commands')
require('autocmds')
require('filetypes')

