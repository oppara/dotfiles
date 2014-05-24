syntax enable

set guioptions-=T
set linespace=4
set columns=140
set number

colorscheme wombat

hi Pmenu guifg=#f6f3e8 guibg=#444444
hi PmenuSel guifg=#000000 guibg=#cae682
hi Cursor guibg=#e7e7e7 guifg=#000000
hi Visual guibg=#ababab guifg=#000000
hi VisualNOS guibg=bg guifg=#ababab gui=bold,underline

set clipboard+=unnamed

" 日本語入力に関する設定:
if has('multi_byte_ime') || has('xim') || ( has('gui_macvim') && has('kaoriya') )
  " " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Green guifg=NONE
  " " 挿入モード・検索モードでのデフォルトのIME状態設定
  " set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif


" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
set guioptions+=a

set visualbell t_vb=
setlocal cursorline


if ( has('win32') )
    if has('kaoriya')
      set ambiwidth=auto
    endif
    set guifont=M+1VM+IPAG_circle_Regular:h12
    set lines=45
    set guioptions+=gmrL
    set antialias
    setlocal hi cursorline
    finish
endif


if !has('mac')
  finish
endif


set lines=40
set guifont=M+1VM+IPAG_circle_Regular:h14

" help macaction
if has('gui_macvim')
  set ambiwidth=double
  set showtabline=2

  set guioptions-=r " スクロールバー非表示
  set guioptions-=L " スクロールバー非表示

  autocmd BufEnter * :set linespace=4
  nnoremap el :set linespace=4<cr>

  set transparency=3
  " set fuoptions=maxvert,maxhorz
  " autocmd GUIEnter * set fullscreen

else
  set nomacatsui
  set antialias
endif

