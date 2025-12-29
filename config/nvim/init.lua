-- cache init.lua
vim.loader.enable()

vim.scriptencoding = 'utf-8'
vim.language = 'C'

--  global
vim.g.oppara_email = 'oppara <oppara _at_ oppara.tv>'
vim.g.snips_author = vim.g.oppara_email
vim.g.changelog_username = 'oppara'

-- matchparen をやめる
vim.g.loaded_matchparen = 1

-- 改行コードが LF に固定されるのを回避
-- https://zenn.dev/oppara/scraps/1442ab8273f73f
vim.g.editorconfig = false

vim.g.is_mac = vim.fn.has('macunix') == 1 or vim.loop.os_uname().sysname == 'Darwin'
vim.g.is_unix = vim.fn.has('unix') == 1 and not vim.g.is_mac
vim.g.is_win = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1

_G.P = function(value)
  if vim.print then
    vim.print(value)
  else
    print(vim.inspect(value))
  end
  return value
end

-- require
require('encodings')
require('options')
require('plugins')
require('colors')
require('mappings')
require('commands')
require('autocmds')
require('filetypes')

if vim.g.vscode == nil then
  require('lsp')
end
