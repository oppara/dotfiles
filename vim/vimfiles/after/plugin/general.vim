" 全角スペースを可視化
scriptencoding utf-8
augroup highlightIdegraphicSpace
  autocmd!
  autocmd BufRead,BufNew * highlight ZenkakuSpace ctermbg=red  ctermfg=red guibg=red  guifg=red
  autocmd BufRead,BufNew * match ZenkakuSpace /　/
augroup END
nnoremap <silent> <leader>mz :highlight ZenkakuSpace ctermbg=red  ctermfg=red guibg=red  guifg=red<cr>


"
" General things that should be done at the very end, to override plugin
" settings
"

if exists('loaded_my_general')
  finish
endif

set formatoptions+=BM

" コメントアウト行の改行時に次行をコメントアウトしない
set formatoptions-=ro


" Function to do <Tab> or completion, based on context {{{
" function MyTabOrCompletion()
	" let col = col('.')-1
	" if !col || getline('.')[col-1] !~ '\k'
		" return "\<tab>"
	" else
		" return "\<C-N>"
	" endif
" endfunction
" }}}

:
"----------------------------------------------------------------------------"
" snippetsEmu : An attempt to emulate TextMate's snippet expansion
" http://www.vim.org/scripts/script.php?script_id=1318
" Map CTRL-B to snippetsEmu and use <Tab> for our smart completion
if exists('loaded_snippet')
  " imap <C-B> <Plug>Jumper
  " inoremap <Tab> <C-R>=MyTabOrCompletion()<CR>    
  " let g:snippetsEmu_key = "<s-cr>"

  " globalなsnippets
  Iabbr da ``strftime("%Y/%m/%d")``
endif

"----------------------------------------------------------------------------"
" taglist.vim : Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc) 
" http://www.vim.org/scripts/script.php?script_id=273
" ctags -R --langmap=PHP:.php --php-types=c+f+d ./
" ctags --verbose -e --recurse --languages=javascript
"
if exists('loaded_taglist')
  noremap <silent> <S-D-t> <ESC>:Tlist<CR>
  noremap <silent> <leader>tl :Tlist<cr><c-w>h

  if has('gui_macvim') && has('kaoriya')
    let Tlist_Ctags_Cmd = '/Applications/MacVim.app/Contents/MacOS/ctags'
  else
    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
  endif
  let Tlist_Show_One_File = 1
  let Tlist_File_Fold_Auto_Close = 1
  let Tlist_Exit_OnlyWindow = 1
  let Tlist_Sort_Type = 'chronological'
  let Tlist_Auto_Highlight_Tag = 1
  let Tlist_Exit_OnlyWindow = 1
  let Tlist_Close_On_Select = 1

  let s:tlist_def_php_settings = 'php;c:class;d:constant;f:function'
  let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method'
endif

"----------------------------------------------------------------------------"
" The NERD Commenter : A plugin that allows for easy commenting of code for many filetypes. 
" http://www.vim.org/scripts/script.php?script_id=1218
" http://d.hatena.ne.jp/tanakaBox/20070409/1176062438
" <leader>cc  コメント
" <leader>cu  コメント削除
" <leader>cA  行末にコメント 
" <leader>c<space>  トグル 
"
if exists('loaded_nerd_comments')
  let NERDSpaceDelims = 1
  let NERDShutUp = 1
endif


"----------------------------------------------------------------------------"
" The NERD tree : A tree explorer plugin for navigating the filesystem 
" http://www.vim.org/scripts/script.php?script_id=1658
"
if exists('loaded_nerd_tree')
  nnoremap <leader>nn <esc>:NERDTreeToggle<cr>
endif


"----------------------------------------------------------------------------"
" xhtml.vim : XHTML syntax highlighting  
" http://www.vim.org/scripts/script.php?script_id=1236
"
" @TODO ftplugin にする
let xhtml_no_embedded_mathml = 1
let xhtml_no_embedded_svg = 1


"----------------------------------------------------------------------------"
" surround.vim : Delete/change/add parentheses/quotes/XML-tags/much more with ease 
" http://www.vim.org/scripts/script.php?script_id=1697
" http://d.hatena.ne.jp/secondlife/20061225
"
if exists('g:loaded_surround')
  nnoremap ,( csw(
  nnoremap ,{ csw{
  nnoremap ,[ csw[
  nnoremap ,' csw'
  nnoremap ," csw"

  autocmd FileType xhtml,html let b:surround_{char2nr('1')}  = "<h1>\r</h1>"
  autocmd FileType xhtml,html let b:surround_{char2nr('2')}  = "<h2>\r</h2>"
  autocmd FileType xhtml,html let b:surround_{char2nr('3')}  = "<h3>\r</h3>"
  autocmd FileType xhtml,html let b:surround_{char2nr('4')}  = "<h4>\r</h4>"
  autocmd FileType xhtml,html let b:surround_{char2nr('5')}  = "<h5>\r</h5>"
  autocmd FileType xhtml,html let b:surround_{char2nr('6')}  = "<h6>\r</h6>"

  autocmd FileType xhtml,html let b:surround_{char2nr('p')} = "<p>\r</p>"
  autocmd FileType xhtml,html let b:surround_{char2nr('u')} = "<ul>\r</ul>"
  autocmd FileType xhtml,html let b:surround_{char2nr('o')} = "<ol>\r</ol>"
  autocmd FileType xhtml,html let b:surround_{char2nr('l')} = "<li>\r</li>"
  autocmd FileType xhtml,html let b:surround_{char2nr('a')} = "<a href=\"\">\r</a>"
  autocmd FileType xhtml,html let b:surround_{char2nr('A')} = "<a href=\"\r\"></a>"
  autocmd FileType xhtml,html let b:surround_{char2nr('i')} = "<img src=\"\r\" alt=\"\" />"
  autocmd FileType xhtml,html let b:surround_{char2nr('I')} = "<img src=\"\" alt=\"\r\" />"
  autocmd FileType xhtml,html let b:surround_{char2nr('d')} = "<div>\r</div>"
endif


"----------------------------------------------------------------------------"
" fuzzyfinder.vim : The buffer/file/MRU/favorite/etc. explorer with the fuzzy pattern
" http://www.vim.org/scripts/script.php?script_id=1984
"
if exists('loaded_autoload_fuf')
  " let g:fuf_patternSeparator = ' '
  let g:fuf_keyNextMode = '<TAB>'
  let g:fuf_keyPrevMode = '<S-TAB>'
  let g:fuf_ignoreCase = 0
  let g:fuf_modesDisable = ['mrucmd']
  let g:fuf_mrufile_maxItem = 1000
  let g:fuf_enumeratingLimit = 20
  let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|COMMIT_EDITMSG'
  let g:fuf_file_exclude = '\v\~$|\.o$|\.exe$|\.bak$|\.swp|\.howm$'
  let g:fuf_dir_exclude = '\v\.svn|((^|[/\\])\.{1,2}[/\\]$)'

  nnoremap <silent> fff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
  nnoremap <silent> ffn :FufBuffer<CR>
  nnoremap <silent> ffm :FufMruFile<CR>
  nnoremap <silent> ffd :FufDir <C-r>=expand('%:p:~')[:-1-len(expand('%:p:~:t'))]<CR><CR>
  nnoremap <silent> ffb :FufBookmark<CR>
  vmap <silent> ffa :FufAddBookmark<CR>

  " http://d.hatena.ne.jp/ns9tks/20080718/1216395697
  " <CR> または <C-m> を2回押すと最後に編集したファイルを開く
  " nnoremap <silent> <C-m> :FuzzyFinderMruFile<CR>
  " <C-j> を2回押すと最後に編集したファイルをウィンドウを水平分割して開く
  " nnoremap <silent> <C-j> :FuzzyFinderMruFile<CR>


endif


"----------------------------------------------------------------------------"
" autocomplpop.vim : Automatically open the popup menu for completion 
" http://www.vim.org/scripts/script.php?script_id=1879
" http://blog.blueblack.net/item_164

if exists('loaded_autoload_acp')
endif
if exists('loaded_autocomplpop')
" " let g:AutoComplPop_MappingDriven = 1
let g:acp_behaviorKeywordLength=3
let g:acp_behaviorFileLength=2
let g:acp_behaviorHtmlOmniLength=1
let g:acp_ignoreCaseOption=1
let g:acp_ignorecaseOption=0
" 
" g:AutoComplPop_CompleteOption:
" " let g:AutoComplPop_NotEnableAtStartup = 1



let jsbehavs = { 'javascript': [] }
    call add(jsbehavs.javascript, {
          \   'command'  : "\<C-n>",
          \   'pattern'  : '\k\k$',
          \   'excluded' : '^$',
          \   'repeat'   : 0,
          \ })
    call add(jsbehavs.javascript, {
          \   'command'  : "\<C-x>\<C-f>",
          \   'pattern'  : (has('win32') || has('win64') ? '\f[/\\]\f*$' : '\f[/]\f*$'),
          \   'excluded' : '[*/\\][/\\]\f*$\|[^[:print:]]\f*$',
          \   'repeat'   : 1,
          \ })
    call add(jsbehavs.javascript, {
          \   'command'  : "\<C-x>\<C-o>",
          \   'pattern'  : '\([^. \t]\.\)$',
          \   'excluded' : '^$',
          \   'repeat'   : 0,
          \ })
if exists('g:acp_behavior')
  call extend(g:acp_behavior, jsbehavs, 'keep')
endif


" http://subtech.g.hatena.ne.jp/cho45/20071111/1194766579
" 補完候補表示したままRETおして改行できるようにする。
" inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"

" 使用するか考え中
" http://d.hatena.ne.jp/cooldaemon/20071114/1195029893
" autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
" autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl_dunctions.dict'
" autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/PHP.dict'
" autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
" autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'
" autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'
" 

endif

"----------------------------------------------------------------------------"
" yanktmp.vim : enables vim to yank and paste through the multi processes 
" http://www.vim.org/scripts/script.php?script_id=1598
if exists('g:loaded_yanktmp')
  map <silent> sy :call YanktmpYank()<CR>
  map <silent> sp :call YanktmpPaste_p()<CR>
  map <silent> sP :call YanktmpPaste_P()<CR>
  if has("mac")
    map <silent> sY :call YankPB()<CR>
    function! YankPB()
      let tmp = tempname()
      call writefile(getline(a:firstline, a:lastline), tmp, 'b')
      silent exec ":!cat " . tmp . " | pbcopy"
    endfunction
  endif
endif


"----------------------------------------------------------------------------"
" YankRing.vim : Maintains a history of previous yanks and deletes 
" http://www.vim.org/scripts/script.php?script_id=1234
" 3.0は、snipetEmuとかぶるので、2.2を使用
" set viminfo+=!





"----------------------------------------------------------------------------"
" modeliner.vim : Generates modeline according to the current settings. 
" http://www.vim.org/scripts/script.php?script_id=1477
"
if exists('g:Modeliner_format')
  let g:Modeliner_format = 'et ts= sts= sw= fdm='
endif


"----------------------------------------------------------------------------"
" smartword : Smart motions on words 
" http://www.vim.org/scripts/script.php?script_id=2470
" http://d.hatena.ne.jp/ns9tks/20090122/1232642747
if exists('g:loaded_smartword')
  " map w  <Plug>(smartword-w)
  " map b  <Plug>(smartword-b)
  " map e  <Plug>(smartword-e)
  " map ge <Plug>(smartword-ge)
  " noremap W  w
  " noremap B  b
  " noremap E  e
  " noremap gE ge
endif

"----------------------------------------------------------------------------"
" smartchr : Insert several candidates with a single key 
" http://www.vim.org/scripts/script.php?script_id=2290
autocmd MyAutoCmd FileType perl inoremap <expr> >  smartchr#one_of('->', '=>', '>')
autocmd MyAutoCmd FileType php inoremap <expr> >  smartchr#one_of('->', '=>', '>')


"----------------------------------------------------------------------------"
" template file loader : Loads a template file and does customizable processing when editing a new file. 
" http://www.vim.org/scripts/script.php?script_id=198
" http://platon.sk/cvs/sk/cvs.php/vimconfig/vim/plugin/templatefile.vim

let g:load_templates="ask"

command! -nargs=1 LoadTmpl call <SID>_LoadTmpl(<args>)
function! <SID>_LoadTmpl(filename)
  let template_file = $HOME . "/.vim/templates/skel." . expand(a:filename)
	if filereadable(template_file)
			silent execute "0r "  . template_file
			setlocal modified
	else
		echo "File " . template_file . " not found!"
    return
	endif

	let date       = Escape(strftime("%Y-%m-%d"))
	let year       = Escape(strftime("%Y"))
	let cwd        = Escape(getcwd())
	let lastdir    = Escape(substitute(cwd, ".*/", "", "g"))
	let myfile     = Escape(expand("%:t:r"))
	let myfile_ext = Escape(expand("%"))
	let inc_gaurd  = Escape(substitute(myfile, "\\.", "_", "g"))
	let inc_gaurd  = Escape(toupper(inc_gaurd))
	if exists("g:author")
		let Author = Escape(g:author)
	else
		let Author = Escape("UNKNOWN AUTHOR")
	endif
	if exists("g:email")
		let Email  = Escape(g:email)
	else
		let Email  = Escape("UNKNOWN@undefined.net")
	endif
	if exists("g:company")
		let Company  = Escape(g:company)
	else
		let Company  = Escape("UNKNOWN Company")
	endif

	" build variable for @JAVA_PACKAGE@ substitution
	" Suggested by Ondrej Jombik 'Nepto' <nepto AT platon.sk>
	" Algoritmus description:
	" nepto@platon.sk    --> #.platon.sk --> sk.platon.@INCLUDE_GAURD@
	" rajo AT platon.sk  --> #.platon.sk  --> sk.platon.@INCLUDE_GAURD@
	let java_pkg = substitute(Email, '^[^@\s]\+\(@\|\s\+AT\s\+\)\(.*\)$', '#.\2', '')
	let java_pkg = substitute(java_pkg, '[^a-zA-Z0-9.]', '', 'g') " remove ugly chars from email address
	let loop_count = 0 " avoid endless loop in while
	while match(java_pkg, '#$') == -1 && loop_count < 10
		let java_pkg = substitute(java_pkg, '^\([^#]*\)#\(.*\)\.\([a-zA-Z0-9_]\+\)$', '\2.\3#\2', 'g')
		let loop_count = loop_count + 1
	endwhile
	let java_pkg = substitute(java_pkg, '^\.\(.*\)#$', '\1.' . tolower(inc_gaurd), '')
	
	silent! execute "%s/@DATE@/"          . date       . "/g"
	silent! execute "%s/@YEAR@/"          . year       . "/g"
	silent! execute "%s/@LASTDIR@/"       . lastdir    . "/g"
	silent! execute "%s/@FILE@/"          . myfile     . "/g"
	silent! execute "%s/@FILE_EXT@/"      . myfile_ext . "/g"
	silent! execute "%s/@PATH_SEP@/"      . path_sep   . "/g"
	silent! execute "%s/@INCLUDE_GAURD@/" . inc_gaurd  . "/g"
	silent! execute "%s/@AUTHOR@/"        . Author     . "/g"
	silent! execute "%s/@EMAIL@/"         . Email      . "/g"
	silent! execute "%s/@COMPANY@/"       . Company    . "/g"
	silent! execute "%s/@JAVA_PACKAGE@/"  . java_pkg   . "/g"
endfunction


" git
"
let git_diff_spawn_mode=1
autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=git

if exists('g:loaded_neocomplcache')

endif


let loaded_my_general = 1
" vim: set fenc=utf-8 et tw=78 ts=2 sts=2 sw=2 fdm=marker : 
