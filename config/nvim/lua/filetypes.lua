local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.cmd([[
" FileType:  

" augroup vimrc-complete
"   autocmd!
"   autocmd FileType * setlocal complete=.,w,b,u,t
"   autocmd FileType * inoremap <buffer> >  >
"
"   " http://vim-users.jp/2009/11/hack96/
"   autocmd FileType *
"         \  if &l:omnifunc == ''
"         \|   setlocal omnifunc=syntaxcomplete#Complete
"         \| endif
" augroup END

augroup vimrc-filetype  "{{{2
  autocmd!

  autocmd BufRead,BufNew *thtml :setlocal filetype=php
  autocmd BufRead,BufNew *ctp :setlocal filetype=php

  autocmd BufRead,BufNew *slim :setlocal filetype=slim

  autocmd BufRead,BufNewFile jquery.*.js :setlocal filetype=javascript syntax=jquery

  autocmd BufRead,BufNewFile *json :setlocal filetype=json syntax=json

  autocmd BufRead,BufNew *scss :setlocal filetype=css

  autocmd BufRead,BufNew *mkd, *.md :setlocal filetype=markdown

  autocmd BufRead,BufNew *snip :setlocal filetype=snippet
augroup END


" " git.vim  "{{{2
" " https://github.com/tpope/vim-git/blob/master/ftplugin/git.vim
" " autocmd AfterPlugin BufRead *.git/COMMIT_EDITMSG DiffGitCached -p | wincmd p
" " autocmd AfterPlugin BufRead *.git/COMMIT_EDITMSG DiffGitCached -p | wincmd L
" " autocmd vimrc BufRead *.git/COMMIT_EDITMSG DiffGitCached -p | only | split | b 1


augroup vimrc-ft-gitrebase  "{{{2
  autocmd!
  " http://sssslide.com/speakerdeck.com/rhysd/do-you-know-about-vim-runtime-files
  autocmd FileType gitrebase nnoremap <buffer>e :<C-u>Edit<CR>
  autocmd FileType gitrebase nnoremap <buffer>s :<C-u>Squash<CR>
  autocmd FileType gitrebase nnoremap <buffer>f :<C-u>Fixup<CR>
  autocmd FileType gitrebase nnoremap <buffer>r :<C-u>Reword<CR>
augroup END




augroup vimrc-ft-php  "{{{2
  autocmd!
  " autocmd FileType php call s:set_php4_syntax_check()
  function! s:set_php4_syntax_check()
    let l:version =  system('php -v|xargs|cut -d " " -f 2|cut -d "." -f 1')
    if l:version == 4
      compiler php
      autocmd BufWritePost * silent make % | redraw!
    endif
  endfunction

  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType php setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
        \| setlocal omnifunc=phpcomplete#CompletePHP
        \| setlocal iskeyword-=-
        \| setlocal keywordprg=:help
        \| setlocal commentstring=//%s
        \| setlocal dictionary+=$MY_VIMRUNTIME/dict/php.dict
        \| setlocal complete-=i
        \| setlocal complete+=k$MY_VIMRUNTIME/dict/php.dict

  autocmd BufRead,BufNew *ctp :setlocal  expandtab tabstop=2 softtabstop=2 shiftwidth=2

  " 辞書作成
  " php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);' | sort > ~/.vim/dict/php.dict

  " surround.vim
  autocmd FileType php let b:surround_{char2nr('e')} = "<?php echo \r; ?>"
        \| let b:surround_{char2nr('p')} = "<?php \r; ?>"
        \| let b:surround_{char2nr('i')} = "__('\r');"
        \| let b:surround_{char2nr('I')} = "<?php echo __('\r'); ?>"
        \| nmap g' cs'g
        \| nmap G' cs'G


  autocmd FileType php nnoremap <buffer>ef :EnableFastPHPFolds<cr>

  autocmd FileType php nnoremap <buffer>su :call PhpSortUse()<cr>

  " autocmd FileType php,blade inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '>>')
  autocmd FileType blade let b:surround_{char2nr('e')} = "{{ \r }}"
        \| let b:surround_{char2nr('p')} = "{!! \r !!}"
        \| highlight PreProc ctermfg=250  ctermbg=none

  " pdv
  let g:pdv_template_dir = $HOME . '/.vim/templates/pdv'
  autocmd FileType php nnoremap <buffer><leader>d :call  pdv#DocumentCurrentLine()<cr>

  " https://github.com/StanAngeloff/php.vim
  function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
  endfunction
  autocmd FileType php call PhpSyntaxOverride()

  " php-cs-fixer
  autocmd FileType php nnoremap <buffer><silent><leader>ti :ALEFix<cr>

augroup END


augroup vimrc-ft-perl  "{{{2
  autocmd!
  autocmd FileType perl setlocal expandtab softtabstop=4 shiftwidth=4
  autocmd FileType perl let s:tidy_cmd = "perltidy -q -st"
  autocmd FileType perl nnoremap <silent><buffer><leader>ti :Tidy<cr>
  autocmd FileType perl vnoremap <silent><buffer><leader>ti <Nop>
  " autocmd FileType perl  inoremap <buffer><expr> > smartchr#one_of('>', '->', '=>', '>>')
" autocmd FileType perl setlocal complete-=i | setlocal complete+=k~/.vim/dict/perl_functions.dict
augroup END


augroup vimrc-ft-html  "{{{2
  autocmd!
  autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType html,xhtml,xml,xslt setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd FileType html,xhtml :setlocal path+=$HOME.'Sites'
        \| :setlocal includeexpr=substitute(v:fname,'^\\/','','')
  autocmd FileType html,xhtml nnoremap <silent><buffer><leader>ti :ALEFix<cr>

  " https://qiita.com/KaoruIto76/items/002d9658b890fb6392f9
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o><CR><ESC>F<i

  " xmllintによる XMLの検証と整形
  " http://nanasi.jp/articles/others/xmllint.html
  " autocmd FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
augroup END

 "}}}"

]])

autocmd({ 'BufRead', 'BufNew' }, {
  pattern = { '*.cf.yaml', '*.cf.yml', '*.cfn.yaml', '*.cfn.yml' },
  callback = function()
    vim.bo.filetype = 'cloudformation.yaml'
  end,
  group = augroup('ft_cloudformation', { clear = true }),
})

autocmd({ 'BufRead', 'BufNew' }, {
  pattern = '*settings.json',
  callback = function()
    vim.bo.filetype = 'jsonc'
  end,
  group = augroup('ft_jsonc', { clear = true }),
})
