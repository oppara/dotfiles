local keymap = vim.api.nvim_set_keymap
local bmap = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- sudo で保存
vim.cmd([[cabbr w!! w !sudo tee > /dev/null %]])

-- tabpage
keymap('n', 'tn', ':tablast <bar> tabnew<CR>', opts)
keymap('n', 'tc', ':tabclose<CR>', opts)
keymap('n', 't]', ':tabnext<CR>', opts)
keymap('n', 't[', ':tabprevious<CR>', opts)
keymap('n', 'tt', 'g<Tab><CR>', opts)
for i = 1, 9 do
  keymap('n', 't' .. i, ':<C-u>tabnext' .. i .. '<CR>', opts)
end

-- ノーマルモードに戻る
keymap('', '<C-j>', '<esc>', opts)
keymap('i', '<C-j>', '<esc>', opts)

-- 単語を置換
keymap('n', 'iw', 'viwp', opts)

-- 最後の編集位置へ戻る
keymap('n', 'gb', '`.zz', opts)
-- 編集位置を遡る
keymap('n', '<C-g>', 'g;', opts)
keymap('n', '0', '^', opts)
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)
keymap('n', '<TAB>', '%', opts)
keymap('v', '<TAB>', '%', opts)

-- カーソル移動
keymap('i', '<C-a>', '<ESC>^i', opts)
keymap('i', '<C-f>', '<RIGHT>', opts)
keymap('i', '<C-e>', '<ESC>A', opts)
keymap('i', '<C-b>', '<LEFT>', opts)
keymap('i', '<C-d>', '<DEL>', opts)
keymap('c', '<C-a>', '<HOME>', opts)
keymap('c', '<C-e>', '<END>', opts)

-- ウィンドウ移動と操作
keymap('n', 'sj', '<C-w>j', opts)
keymap('n', 'sk', '<C-w>k', opts)
keymap('n', 'sl', '<C-w>l', opts)
keymap('n', 'sh', '<C-w>h', opts)
keymap('n', 'ss', ':<C-u>sp<CR><C-w>j', opts)
keymap('n', 'sv', ':<C-u>vs<CR><C-w>l', opts)
keymap('n', 'sq', ':<C-u>q<CR>', opts)

-- list, number,  paste のトグル
keymap('n', 'tl', ':set list!<cr>', opts)
keymap('n', 'tm', ':set number!<cr>', opts)
keymap('n', 'tp', ':setlocal paste!<cr>', opts)

-- hlsearch のトグル
keymap('n', 'gh', '', {
  noremap = true,
  silent = true,
  callback = function()
    if vim.opt.hlsearch:get() then
      vim.opt_local.hlsearch = false
    else
      vim.opt_local.hlsearch = true
    end
  end,
})

-- ビジュアルモード時vで行末まで選択
keymap('v', 'v', '$h', opts)

-- like screen
keymap('v', '<space>', 'y', opts)

--  >,<実行後も選択状態を維持
keymap('v', '>', '>gv', opts)
keymap('v', '<', '<gv', opts)

-- 行頭で h を叩くと折畳を閉じる。
keymap('n', 'h', [[col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h']], { expr = true, noremap = true })
--  折畳上で l を叩くと折畳を開く。
keymap('n', 'l', [[foldclosed(line('.')) != -1 ? 'zo0' : 'l']], { expr = true, noremap = true })
-- 行頭で h を叩くと選択範囲に含まれる折畳を閉じる。
keymap('v', 'h', [[col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h']], { expr = true, noremap = true })
-- 折畳上で l を叩くと選択範囲に含まれる折畳を開く。
keymap('v', 'l', [[foldclosed(line('.')) != -1 ? 'zogv0' : 'l']], { expr = true, noremap = true })

-- レジスタ/マークの確認
keymap('n', '<leader>sm', ':<C-u>marks<CR>', opts)
keymap('n', '<leader>sr', ':<C-u>registers<CR>', opts)

-- エンコーディングの切り替え
keymap('n', 'eu', ':setlocal fileencoding=utf-8<CR>', opts)
keymap('n', 'ee', ':setlocal fileencoding=euc-jp<CR>', opts)
keymap('n', 'es', ':setlocal fileencoding=cp932<CR>', opts)
keymap('n', 'el', ':setlocal fileencoding=utf-16le<CR>', opts)

-- エンコーディングを指定して再オープン
keymap('n', 'reu', ':e ++enc=utf-8 %<CR>', opts)
keymap('n', 'ree', ':e ++enc=euc-jp %<CR>', opts)
keymap('n', 'res', ':e ++enc=cp932 %<CR>', opts)
keymap('n', 'rel', ':e ++enc=utf-16le %<CR>', opts)

-- 改行切り替え
keymap('n', 'ffu', ':setlocal fileformat=unix<CR>', opts)
keymap('n', 'ffd', ':setlocal fileformat=dos<CR>', opts)

-- retab
keymap('n', '<leader>rt', ':%retab!<CR>', opts)

-- 日付
keymap('i', '<leader>df', "<C-r>=strftime('%y-%m-%d %h:%m:%s')<return>", opts)
keymap('i', '<leader>dd', "<C-r>=strftime('%y-%m-%d')<return>", opts)

-- ^m を削除
keymap('n', '<leader>rw', "mmhmt:%s/<C-v><CR>//ge<CR>'tzt'm", opts)

-- 空行上のインデントを削除
keymap('n', '<leader>ri', [[:%s/\s*$//g<cr>:noh<cr>'']], opts)

-- vimrc
keymap('n', '<leader>ev', ':sp $MYVIMRC<CR>', opts)
keymap('n', '<leader>vv', '', {
  noremap = true,
  silent = true,
  callback = function()
    vim.cmd([[source $MYVIMRC]])
  end,
})
--[[
if (!exists('*SourceConfig'))
  function SourceConfig() abort
    " Your path will probably be different
    for f in split(glob('~/.config/nvim/autoload/*'), '\n')
      exe 'source' f
    endfor

    source $MYVIMRC
  endfunction
endif
]]

-- use({"ckipp01/stylua-im"})"
-- buf_set_keymap("n", "<leader>f", [[<cmd>lua require("stylua-im").format_file()<cr>]], opts)")]])

--[[

" complete
" 補完表示時にenterを押しても改行せずに確定
-- https://github.com/willelz/im-lua-guide-ja/blob/master/README.ja.md#:~:text=%E3%81%99%E3%82%8BAPI%E9%96%A2%E6%95%B0-,im_replace_termcodes(),-%E3%81%8C%E3%81%82%E3%82%8A%E3%81%BE%E3%81%99
inoremap <expr><cr>  pumvisible() ? "<c-y>" : "<cr>"
" c-n, c-p で補完候補を挿入せず、選択だけ行う
inoremap <expr><c-n> pumvisible() ? "<down>" : "<c-n>"
inoremap <expr><c-p> pumvisible() ? "<up>" : "<c-p>"


" 検索結果をquickfixに表示
" http://subtech.g.hatena.ne.jp/secondlife/20070601/1180700503
nnoremap  q/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<cr>
" nnoremap <unique> q/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<cr>

" expand path
cnoremap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cnoremap <c-z> <c-r>=expand('%:p:r')<cr>


" 現在使用中のバッファの表示
nnoremap bb :ls<cr>:buffer

--]]
