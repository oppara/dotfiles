set nocompatible

"----------------------------------------------------------------------------"
" global vars
"----------------------------------------------------------------------------"
let g:opp_localhost = 'http://macbook/'
let g:opp_docroot = '/Users/oppara/Sites/'
let g:opp_email = '<oppara _at_ oppara.tv>'
let g:snips_author = '<oppara _at_ oppara.tv>'
" let g:changelog_username = 'Nobuo OOHARA ' . g:opp_email
let g:changelog_username = ''


let mapleader = ','
let g:mapleader = ','

" http://www.removabletype.net/vim/vim_matchparen.html#more-281
let loaded_matchparen = 1




" " Encoding " "
" gvim‚Ìexploer‚ª‚¤‚Ü‚­“®ì‚µ‚È‚¢‚Ì‚ÅƒRƒƒ“ƒgƒAƒEƒg‚·‚éB
" set encoding=japan
if has('gui_macvim')
  let did_encoding_settings = 1
endif
if !exists('did_encoding_settings')
  if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'

    " Does iconv support JIS X 0213 ?
    if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213,euc-jp'
      let s:enc_jis = 'iso-2022-jp-3'
    endif

    " Make fileencodings
    let &fileencodings = 'ucs-bom'
    if &encoding !=# 'utf-8'
      let &fileencodings = &fileencodings . ',' . 'ucs-2le'
      let &fileencodings = &fileencodings . ',' . 'ucs-2'
    endif
    let &fileencodings = &fileencodings . ',' . s:enc_jis

    if &encoding ==# 'utf-8'
      let &fileencodings = &fileencodings . ',' . s:enc_euc
      let &fileencodings = &fileencodings . ',' . 'cp932'
    elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      let &encoding = s:enc_euc
      let &fileencodings = &fileencodings . ',' . 'utf-8'
      let &fileencodings = &fileencodings . ',' . 'cp932'
    else  " cp932
      let &fileencodings = &fileencodings . ',' . 'utf-8'
      let &fileencodings = &fileencodings . ',' . s:enc_euc
    endif
    let &fileencodings = &fileencodings . ',' . &encoding

    unlet s:enc_euc
    unlet s:enc_jis

  else
    set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
    let &fileencodings = 'ucs-bom,iso-2022-jp-3,ucs-2le,ucs-2,' .
          \ ((&encoding ==# 'utf-8') ? 'cp932,euc-jisx0213,euc-jp' :
          \  (&encoding ==# 'cp932') ? 'utf-8,euc-jisx0213,euc-jp' :
          \                            'utf-8,cp932'                ) " 'euc-jp' 'euc-jisx0213'
  endif

  let did_encoding_settings = 1
endif

if ( !has('win32') )
    set termencoding=utf-8
endif

set fileformats=unix,dos,mac


"----------------------------------------------------------------------------"
if 1 < &t_Co && has('syntax')
  if &term ==# 'rxvt-cygwin-native'
    set t_Co=256
  endif
  syntax enable
  colorscheme default
  set background=dark
endif

filetype plugin on
filetype indent on

set nonumber
"ƒ‹[ƒ‰[•\¦‚³‚¹‚é‚Æ“ú–{Œê“ü—Í‚ª‚¨‚©‚µ‚­‚È‚éê‡‚ ‚è
set noruler
" “ü—Í’†‚Ìƒ^ƒu•âŠ®‚ğ‹­‰»
set wildmenu
" “ü—Í•âŠ®‚Ìİ’èiƒŠƒXƒg•\¦‚ÅÅ’·ˆê’vA‚»‚ÌŒã‘I‘ğj
set wildmode=list:longest,full

set showmatch
set showcmd
set lazyredraw
set history=400
set hidden
set autoread
" set autowrite
set nobackup
set nowritebackup
set noswapfile

set scrolloff=10000
set nolist
set listchars=tab:>_,eol:<,trail:_,extends:\
set startofline
set grepprg=internal

set viminfo='10,\"100,:20,%,n~/.viminfo

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set cindent
set cinkeys+=;
"Wrap lines
set wrap

" backspaceƒL[‚Ì‹““®‚ğİ’è‚·‚é
" indent	: s“ª‚Ì‹ó”’‚Ìíœ‚ğ‹–‚·
" eol		: ‰üs‚Ìíœ‚ğ‹–‚·
" start		: ‘}“üƒ‚[ƒh‚ÌŠJnˆÊ’u‚Å‚Ìíœ‚ğ‹–‚·
set backspace=eol,start,indent
" backspaceƒL[‚ÅƒCƒ“ƒfƒ“ƒg•‚ğíœ
set smarttab


" " Search " "
set magic
set hlsearch
nohlsearch
" ŒŸõ•¶š—ñ‚ª¬•¶š‚Ìê‡‚Í‘å•¶š¬•¶š‚ğ‹æ•Ê‚È‚­ŒŸõ‚·‚é
set ignorecase
" ŒŸõ•¶š—ñ‚É‘å•¶š‚ªŠÜ‚Ü‚ê‚Ä‚¢‚éê‡‚Í‹æ•Ê‚µ‚ÄŒŸõ‚·‚é
set smartcase
" ŒŸõ‚ÉÅŒã‚Ü‚Ås‚Á‚½‚çÅ‰‚É–ß‚é
set wrapscan
" ŒŸõ•¶š—ñ“ü—Í‚É‡Ÿ‘ÎÛ•¶š—ñ‚Éƒqƒbƒg‚³‚¹‚È‚¢
set noincsearch

set whichwrap=b,s,h,l,<,>,[,]
set ambiwidth=double
" set iminsert=0 imsearch=0

" 2ŒÂã‚ÌƒfƒBƒŒƒNƒgƒŠˆÈ‰º‚©‚çÄ‹A“I‚É’T‚·
set tags=+../../**/tags
" ƒJƒŒƒ“ƒgƒfƒBƒŒƒNƒgƒŠ‚©‚çeƒfƒBƒŒƒNƒgƒŠ‚ğ‚³‚©‚Ì‚Ú‚Á‚Ä’T‚·
set tags=+tags;


" " Statusline " "
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P


" " Folding " "
set foldenable
set foldlevel=0
set foldmethod=marker


" " Mapping " "
" inoremap <S-Space> <C-p> "macvim7‚Å‚Í“®ì‚¹‚¸AA
nnoremap <leader>f f{V%=}


nnoremap <C-j> <esc>
vnoremap <C-j> <esc>
inoremap <c-j>  <esc>
"http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/options.html#'iminsert'
"ƒRƒ}ƒ“ƒh <Esc> ‚ÅInsertƒ‚[ƒh‚ğI‚¦‚é“x‚É’l‚ğ 0 ‚É–ß‚·‚É‚ÍˆÈ‰ºB
" inoremap <silent> <esc> <esc>:set iminsert=0<cr>
inoremap <silent> <esc> <esc>:set iminsert=0<cr>
inoremap <silent> <c-j> <esc>:set iminsert=0<cr>

" http://vim.g.hatena.ne.jp/ka-nacht/20081123/1227366577
inoremap <return> <return>X<bs>

" eregex.vim
" http://www.vector.co.jp/soft/unix/writing/se265654.html
" :%s # vim‚Ì³‹K•\Œ»‚É‚æ‚é’uŠ·
" :%S # eregex‚Ì³‹K•\Œ»vim‚É‚æ‚é’uŠ·
" :%g # vim‚Ì(ry
" :%G # eregex‚Ì(ry
" / # vim‚Ì(ry
" :M/ # eregex ‚Ì(ry 
nnoremap / :set noincsearch<cr>:set hlsearch<cr>:M/
" org
nnoremap ,/ :set noincsearch<cr>:set hlsearch<cr>/

if has( 'migemo' )
  set migemo
  nnoremap m/ :set incsearch<cr>:set hlsearch<cr>g/
endif

" ‚¸‚Á‚ÆƒnƒCƒ‰ƒCƒg‚Í‚¤‚´‚¢
" nnoremap <silent> gh :let @/=''<cr>
nnoremap <silent> gh :<c-u>setlocal nohlsearch<cr>

" ŒŸõŒ‹‰Ê‚ğquickfix‚É•\¦
" http://subtech.g.hatena.ne.jp/secondlife/20070601/1180700503
nnoremap  q/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<cr>
" nnoremap <unique> q/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<cr>

" save
nnoremap <leader><leader> :up<cr>
noremap <c-s> :up<cr>
inoremap <leader><leader> <esc>:up<cr>
inoremap <c-s> <esc>:up<cr>a

" like screen
vnoremap <space> y

" ƒrƒWƒ…ƒAƒ‹ƒ‚[ƒh‚Å‘I‘ğ‚µ‚½ƒeƒLƒXƒg‚ğŒŸõ
vnoremap * y/<c-r>0<cr>

" http://relaxedcolumn.blog8.fc2.com/blog-entry-125.html
if has('mac')
  nnoremap <silent> <leader>y :.w !pbcopy<cr><cr>
  vnoremap <silent> <leader>y :w !pbcopy<cr><cr>
  nnoremap <silent> <leader>p :r !pbpaste<cr>
  vnoremap <silent> <leader>p :r !pbpaste<cr>
endif


" ƒrƒWƒ…ƒAƒ‹ƒ‚[ƒhv‚Ås––‚Ü‚Å‘I‘ğ
vnoremap v $h

" pasteƒ‚[ƒh‚ÌØ‚è‘Ö‚¦
" paste/nopaste
nnoremap <leader>v :set paste<cr>
inoremap <leader>v <c-o>:set paste<cr>
nnoremap <leader>nv :set nopaste<cr>
set pastetoggle=<f2>

nnoremap <leader>ow
\  :<C-u>setlocal wrap!
\ \|     setlocal wrap?<cr>

" nnoremap ep :set invpaste<cr>


" ÅŒã‚É•ÏX‚³‚ê‚½ƒeƒLƒXƒg‚ğ‘I‘ğ‚·‚é
" gv‚ÅÅŒã‚ÉVisual mode‚Å‘I‘ğ‚³‚ê‚½—Ìˆæ‚ğÄ“x‘I‘ğ‚Å‚«‚é
nnoremap gc  `[v`]


" ƒŒƒWƒXƒ^/ƒ}[ƒN‚ÌŠm”F‚ğŠy‚É‚·
nnoremap <leader>sm  :<C-u>marks<cr>
nnoremap <leader>sr  :<C-u>registers<cr>


" move
nnoremap 0 ^
nnoremap j gj
nnoremap k gk

" emacs like C-a C-e C-f C-b
inoremap <C-a> <esc>^i
inoremap <C-f> <Right>
inoremap <C-e> <esc>A
inoremap <C-b> <Left>
inoremap <C-D>  <Del>

cnoremap <C-A>    <Home>
cnoremap <C-E>    <End>
" expand path
cnoremap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cnoremap <c-z> <c-r>=expand('%:p:r')<cr>

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '/' ? '\?' : '/'

" " pseudo vi-like keys
" cnoremap <Esc>h  <Left>
" cnoremap <Esc>j  <Down>
" cnoremap <Esc>k  <Up>
" cnoremap <Esc>l  <Right>
" cnoremap <Esc>H  <Home>
" cnoremap <Esc>L  <End>
" cnoremap <Esc>w  <S-Right>
" cnoremap <Esc>b  <S-Left>
" cnoremap <Esc>x  <Del>

nnoremap bb :ls<cr>:buffer 
" nnoremap bb :bNext<cr>

" ƒJ[ƒ\ƒ‹‰º‚Ì’PŒê‚ğÅŒã‚Éƒ„ƒ“ƒN‚µ‚½ƒeƒLƒXƒg‚Å’u‚«Š·‚¦
nnoremap yp wbdiw"0P


" encoding
nnoremap <silent> eu :setlocal fileencoding=utf-8<cr>
nnoremap <silent> ee :setlocal fileencoding=euc-jp<cr>
nnoremap <silent> es :setlocal fileencoding=cp932<cr>
nnoremap <silent> el :setlocal fileencoding=utf-16le<cr>

" encode reopen encoding
nnoremap <silent> reu :e ++enc=utf-8 %<cr>
nnoremap <silent> ree :e ++enc=euc-jp %<cr>
nnoremap <silent> res :e ++enc=cp932 %<cr>
nnoremap <silent> rel :e ++enc=utf-16le %<cr>

" fileformat
nnoremap <silent>ffd :setlocal fileformat=dos<cr>
nnoremap <silent>ffu :setlocal fileformat=unix<cr>
nnoremap <silent>ffm :setlocal fileformat=mac<cr>

" shiftwidth
nnoremap <leader>t2 :setlocal shiftwidth=2<cr>
nnoremap <leader>t4 :setlocal shiftwidth=4<cr>

" syntax change
nnoremap <leader>1 :call <SID>SetFtSynTab('html')<cr>
nnoremap <leader>2 :call <SID>SetFtSynTab('css')<cr>
nnoremap <leader>3 :call <SID>SetFtSynTab('javascript')<cr>
nnoremap <leader>4 :call <SID>SetFtSynTab('php')<cr>

" Input: datetime
inoremap <Leader>dF  <C-r>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<Return>
inoremap <Leader>df  <C-r>=strftime('%Y-%m-%d %H:%M:%S')<Return>
inoremap <Leader>dd  <C-r>=strftime('%Y-%m-%d')<Return>
inoremap <Leader>dT  <C-r>=strftime('%H:%M:%S')<Return>
inoremap <Leader>dt  <C-r>=strftime('%H:%M')<Return>

" quickfix
nnoremap Q q

nnoremap qo  :copen<Return>:execute "set modifiable"<cr>
nnoremap qc  :cclose<Return>
nnoremap qj  :cnext<Return>
nnoremap qk  :cprevious<Return>
nnoremap qq  :cc<Return>
nnoremap q   <Nop>

nnoremap t  <Nop>
nnoremap tt  <C-]>           " u”ò‚Ôv
nnoremap tj  :<C-u>tag<cr>   " ui‚Şv
nnoremap tk  :<C-u>pop<cr>   " u–ß‚év
nnoremap tl  :<C-u>tags<cr>  " —š—ğˆê——

" tab to space
noremap <Leader>rt :%retab!<cr>

"Remove the Windows ^M
noremap <Leader>rw mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Remove indenting on empty lines
noremap <Leader>ri :%s/\s*$//g<cr>:noh<cr>''


" http://d.hatena.ne.jp/ns9tks/searchdiary?word=folding
" s“ª‚Å h ‚ğ‰Ÿ‚·‚ÆÜô‚ğ•Â‚¶‚éB
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" Üôã‚Å l ‚ğ‰Ÿ‚·‚ÆÜô‚ğŠJ‚­B
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" s“ª‚Å h ‚ğ‰Ÿ‚·‚Æ‘I‘ğ”ÍˆÍ‚ÉŠÜ‚Ü‚ê‚éÜô‚ğ•Â‚¶‚éB
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" Üôã‚Å l ‚ğ‰Ÿ‚·‚Æ‘I‘ğ”ÍˆÍ‚ÉŠÜ‚Ü‚ê‚éÜô‚ğŠJ‚­B
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'


" http://d.hatena.ne.jp/ns9tks/20080717/1216310786
" ‘I‘ğ”ÍˆÍ‚ğƒpƒ^[ƒ“‚É‚µ‚ÄŒŸõ
function! s:SetSearch(text, is_word)
  let pattern = substitute(escape(a:text, '\'), '\n', '\\n', 'g')
  if a:is_word
    let @/ = '\C\V\<' . pattern . '\>'
  else
    let @/ = '\C\V' . pattern
  endif
  call histadd('/', pattern)
  set hlsearch
endfunction

vnoremap <silent> *  :<C-u>call <SID>SetSearch(<SID>SelectedText(), 1)<cr>
vnoremap <silent> g* :<C-u>call <SID>SetSearch(<SID>SelectedText(), 0)<cr>


" " Color " "
colorscheme opp2

highlight Pmenu ctermbg=black
highlight PmenuSel ctermfg=black ctermbg=white
highlight PmenuSbar ctermbg=0


" " Comlete and Dictionary " "
set completeopt=menu,preview,longest,menuone
" help cpt
set complete=.,w,b,u,k,i

set completefunc=syntaxcomplete#Complete
set omnifunc=syntaxcomplete#Complete
" 

"function InsertTabWrapper()
"    if pumvisible()
"        return "\<c-n>"
"    endif
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
"        return "\<tab>"
"    elseif exists('&omnifunc') && &omnifunc == ''
"        return "\<c-n>"
"    else
"        return "\<c-x>\<c-o>"
"    endif
"endfunction


" " Autocmd " "
augroup MyAutoCmd
  autocmd!
augroup END

autocmd MyAutoCmd FileType * set complete=.,w,b,u,t
autocmd MyAutoCmd FileType perl setlocal complete-=i | setlocal complete+=k~/.vim/dict/perl_functions.dict
autocmd MyAutoCmd FileType php setlocal complete-=i | setlocal complete+=k~/.vim/dict/PHP.dict
" autocmd MyAutoCmd FileType ruby setlocal complete+=k~/.vim/dict/ruby.dict
autocmd MyAutoCmd FileType javascript setlocal complete+=k~/.vim/dict/javascript.dict

autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd MyAutoCmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

autocmd MyAutoCmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif


"•ÒW’†‚Ìƒtƒ@ƒCƒ‹–¼‚ğ screen ‚Ìƒ^ƒCƒgƒ‹‚É•\¦‚·‚é
if &term =~ "screen"
  " if &term !~ "xterm-color"
  autocmd MyAutoCmd BufEnter * 
    \ if bufname("") !~ "^\[A-Za-z0-9\]*://" 
    \ | silent! exe '!echo -n "k[`basename %`]\\"' 
    \ | endif
  autocmd MyAutoCmd VimLeave * 
    \ silent! exe '!echo -n "k`dirs`\\"'
endif

autocmd MyAutoCmd FileType svn setlocal fileencoding=utf-8

" “ú–{Œê‚ğŠÜ‚Ü‚È‚¢ê‡‚ÉJIS‚Æ‰ğß‚³‚ê‚é‚Ì‚ğ–h‚®
autocmd MyAutoCmd BufReadPost *
      \   if &modifiable && !search('[^\x00-\x7F]', 'cnw') && &filetype != 'svn'
      \ |   setlocal fileencoding=
      \ | endif

" Œ»İ•ÒW’†‚Ìƒoƒbƒtƒ@‚ÌƒfƒBƒŒƒNƒgƒŠ‚ÉˆÚ“®‚·‚é
autocmd MyAutoCmd BufEnter * execute ":lcd " . expand("%:p:h") 

"Restore cursor to file position in previous editing session
autocmd MyAutoCmd BufReadPost * 
    \   if line("'\"") > 0
    \ |   if line("'\"") <= line("$")
    \ |     exe("norm '\"")
    \ |    else
    \ |     exe "norm $"
    \ |   endif
    \ | endif


" autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
autocmd MyAutoCmd QuickfixCmdPost grep,grepadd,vimgrep copen
autocmd MyAutoCmd QuickfixCmdPost l* lopen


autocmd MyAutoCmd FileType vim
      \ call <SID>SetShortIndent()

autocmd MyAutoCmd FileType css
      \ call <SID>SetShortIndent()

autocmd MyAutoCmd FileType ruby
      \   call <SID>SetShortIndent()

autocmd MyAutoCmd FileType sh
      \ call <SID>SetShortIndent()

autocmd MyAutoCmd FileType python
      \   call <SID>SetShortIndent()
      \ | let python_highlight_numbers=1
      \ | let python_highlight_builtins=1
      \ | let python_highlight_space_errors=1

autocmd MyAutoCmd FileType yaml
      \ call <SID>SetShortIndent()

autocmd MyAutoCmd FileType javascript
      \ call <SID>SetShortIndent()

" http://nanasi.jp/articles/others/xmllint.html
" xmllint‚É‚æ‚é XML‚ÌŒŸØ‚Æ®Œ`
autocmd MyAutoCmd FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null" 

autocmd MyAutoCmd FileType html,xhtml,xml,xslt
      \ call <SID>FileType_xml()

function! s:FileType_xml()
  call <SID>SetShortIndent()
endfunction

autocmd MyAutoCmd FileType html,xhtml,php,css,javascript
      \ call <SID>FileType_web()

function! s:FileType_web()
   nnoremap  <silent><leader>r :call <SID>RunSafari()<cr>
   inoremap <silent><leader>r <esc>:call <SID>RunSafari()<cr> 
   noremap <silent> <leader>rf :call <SID>RunFirefox()<cr>
endfunction

autocmd MyAutoCmd FileType html,xhtml :setlocal path+=$HOME.'Sites'
autocmd MyAutoCmd FileType html,xhtml :setlocal includeexpr=substitute(v:fname,'^\\/','','')

" cakephp
autocmd MyAutoCmd BufRead,BufNew *thtml :setlocal filetype=php
autocmd MyAutoCmd BufRead,BufNew *ctp :setlocal filetype=php
" markdown
autocmd MyAutoCmd BufRead *.mkd  setlocal autoindent formatoptions=tcroqn2 comments=n:>


autocmd MyAutoCmd QuickfixCmdPost make call <SID>PostQuickfixCmd()

function! s:PostQuickfixCmd()
  if len(getqflist()) > 0
    cw
  else
    cclose
  endif
endfunction


"----------------------------------------------------------------------------"
" w’èŒ…‚ÌƒZƒpƒŒ[ƒ^ƒRƒƒ“ƒg‚ğ‘}“ü
" http://d.hatena.ne.jp/ns9tks/20081127/1227757541
function! <SID>GetSeparatorLineString(pre, char, post, col_len)
  let chars_len =  a:col_len - (virtcol(".") - 1) - strlen(a:pre) - strlen(a:post)
  if chars_len < 0 || strlen(a:char) == 0
    return ''
  endif
  return  a:pre . repeat(a:char, chars_len / strlen(a:char)) . a:post
endfunction
inoremap <expr> <C-\>   <Nop>
inoremap <expr> <C-\>// <SID>GetSeparatorLineString('//', '/', ''        , 78)
inoremap <expr> <C-\>/- <SID>GetSeparatorLineString('//', '-', ''        , 78)
inoremap <expr> <C-\>/. <SID>GetSeparatorLineString('//', '.', ''        , 78)
inoremap <expr> <C-\>/* <SID>GetSeparatorLineString('/*', '*', '*/'      , 78)
inoremap <expr> <C-\>"" <SID>GetSeparatorLineString('"' , '"', ''        , 78)
inoremap <expr> <C-\>-- <SID>GetSeparatorLineString('-' , '-', ''        , 78)
inoremap <expr> <C-\>== <SID>GetSeparatorLineString('=' , '=', ''        , 78)
inoremap <expr> <C-\>"- <SID>GetSeparatorLineString('"' , '-', ''        , 78)
inoremap <expr> <C-\>". <SID>GetSeparatorLineString('"' , '.', ''        , 78)
inoremap <expr> <C-\>## <SID>GetSeparatorLineString('#' , '#', ''        , 78)
inoremap <expr> <C-\>#- <SID>GetSeparatorLineString('#' , '-', ''        , 78)
inoremap <expr> <C-\>#. <SID>GetSeparatorLineString('#' , '.', ''        , 78)
inoremap <expr> <C-\>;; <SID>GetSeparatorLineString(';' , ';', ''        , 78)
inoremap <expr> <C-\>(* <SID>GetSeparatorLineString('(' , '*', ')'       , 78)
inoremap <expr> <C-\>={ <SID>GetSeparatorLineString('=' , '=', ' {{'.'{1', 78)
inoremap <expr> <C-\>=} <SID>GetSeparatorLineString('=' , '=', ' }}'.'}1', 78)
inoremap <expr> <C-\>-{ <SID>GetSeparatorLineString('-' , '-', ' {{'.'{1', 78)
inoremap <expr> <C-\>-} <SID>GetSeparatorLineString('-' , '-', ' }}'.'}1', 78)




"----------------------------------------------------------------------------"
" Tidy
"
command! -bar -narg=0 Tidy call <SID>Tidy()
nnoremap <silent> <leader>ti :call <SID>Tidy( )<cr>
function! s:Tidy( )
  execute ':up|normal ma'
  let cmd = ''
  if &syntax == 'perl'
    let cmd = '/usr/local/bin/perltidy -q -st'
  elseif &syntax == 'php'
    let cmd = $HOME . '/.vim/tools/phpStylist.sh %'
    " let cmd = '~/bin/php_beautifier'
  elseif &syntax == 'javascript'
    " let cmd = '~/bin/jstidy %'
    " let cmd = '~/bin/js -f ~/bin/js_tidy.js'
  elseif &syntax == 'html' || &syntax == 'xhtml'
    let cmd = '/usr/bin/tidy  -config ~/.tidyrc'
  elseif &syntax == 'css'
let cmd= '~/bin/csstidy - --silent=true --preserve_css=true --template=default --compress_font-weight=false  --lowercase_s=true  --case_properties=1  --compress_colors=false'
  endif

  if cmd == ''
    return
  endif

  execute ':%:!' . cmd 
  execute ':normal `a'
  " execute ':normal! ggVG='
endf



function! s:RunSafari()
  :update
  let b:fullpath = expand( "%:p" )
  let s:url = substitute( b:fullpath, g:opp_docroot, g:opp_localhost, '' )
  "echo $url
  silent exec '!open -a safari ' . s:url
  " !open -a safari $url
endfunction 

function! s:RunFirefox()
  :update
  let b:fullpath = expand( "%:p" )
  let s:url = substitute( b:fullpath, g:opp_docroot, g:opp_localhost, '' )
  silent exec '!fresno -p ' . s:url
endfunction 

function! s:ReloadFirefox()"{{{
  :update
  if has('mac')
    !osascript -e 'tell app "Firefox"' -e 'activate' -e 'end tell' -e 'tell application "System Events"' -e 'keystroke "r" using command down' -e 'end tell'
  elseif has('win32')
  endif
endfunction"}}}


"----------------------------------------------------------------------------"
" {‚ÌŒã‚É<ENTER>‚ğ‰Ÿ‚·‚Æˆês‹ó‚¯‚Ä‰üs
inoremap <silent> <enter> <c-r>=<SID>SmartEnter()<cr>
function! s:SmartEnter()
  let line = getline( "." )
  let brace = strpart( line, strlen( line ) - 2, 2 )
  if ( brace == '{}' )
    return "\<cr>\<cr>\<esc>ka\<TAB>"
  else
    return "\<cr>"
  endif
endf

nnoremap <silent> <Leader>e  :<C-u>call <SID>MyIndent()<Return>
function! s:MyIndent()
  let cursor_pos = getpos('.')
  let cursor_line = cursor_pos[1]

  normal! 0
  if (search('^[^{]*{', 'ce', cursor_line) == 0
  \   && search('^[^}]*}', 'ce', cursor_line) == 0)
    call setpos('.', cursor_pos)
    return
  endif

  normal! =aB
endfunction


function! s:SetShortIndent()
  setlocal expandtab softtabstop=2 shiftwidth=2
endfunction

function! s:SetFtSynTab(type)
  execute 'setlocal filetype='.a:type.'| setlocal syntax='.a:type
  if  a:type == 'php'
    setlocal expandtab softtabstop=4 shiftwidth=4
  else
    inoremap <expr> > smartchr#one_of( '>' )
    call <SID>SetShortIndent()
  endif
endfunction

" snipMateÄ“Ç‚İ‚İBxxx.snippet‚ğŠJ‚¢‚Ä‚¢‚é‚Æ‚«‚É:call SnipMateReload()‚·‚ê‚Î‚n‚j
" http://webtech-walker.com/archive/2009/10/26021358.html
function! SnipMateReload()
    if &ft == 'snippet'
        let ft = substitute(expand('%'), '.snippets', '', '')
        if has_key(g:did_ft, ft)
            unlet g:did_ft[ft]
        endif
        silent! call GetSnippets(g:snippets_dir, ft)
    endif
endfunction


" " ~/.vimrc " "
" reload
nnoremap <leader>vs :source ~/.vimrc<cr>
" edit
nnoremap <leader>ve :sp ~/.vimrc<cr>
"When .vimrc is edited, reload it
" autocmd! bufwritepost vimrc source ~/.vimrc


" fuzzyfinder.vim 
let g:fuf_modesDisable = ['mrucmd']

" AutoComplPop
let g:acp_behaviorSnipmateLength=1

command! -complete=file -nargs=+ Grep call s:grep([<f-args>])
function! s:grep(args)
    let target = len(a:args) > 1 ? join(a:args[1:]) : '**/*'
    execute 'vimgrep' '/' . a:args[0] . '/j ' . target
    if len(getqflist()) != 0 | copen | endif
endfunction

if !exists('s:loaded_my_vimrc')
    let s:loaded_my_vimrc = 1

    " hatena.vim
    set runtimepath+=$HOME/.vim/hatena

    " http://nanasi.jp/articles/vim/matchit_vim.html
    source $VIMRUNTIME/macros/matchit.vim
    
    " autocmd MyAutoCmd VimEnter *
    "   \ doautocmd MyAutoCmd User DelayedSettings
else
    " doautocmd MyAutoCmd User DelayedSettings
endif
