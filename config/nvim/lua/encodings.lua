vim.cmd([[

if !exists('did_encoding_settings') "{{{3

  " http://www.kawaz.jp/pukiwiki/?vim
  " http://www.ksknet.net/vi/vim_1.html
  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif

  if has('iconv') "{{{4

    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'eucjp-ms'
      let s:enc_jis = 'iso-2022-jp-3'
      " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213'
      let s:enc_jis = 'iso-2022-jp-3'
    endif

    " fileencodingsを構築
    if &encoding ==# 'utf-8'

      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc

      if s:fileencodings_default =~ 'utf-8'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        let &fileencodings = substitute(&fileencodings, "utf-8", "utf-8,cp932", "g")
      else
        let &fileencodings = &fileencodings .',cp932,'. s:fileencodings_default
      endif
      unlet s:fileencodings_default

    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding = s:enc_euc
        let &fileencoding = s:enc_euc
      else
        let &fileencodings = &fileencodings .','. s:enc_euc
      endif
    endif

    unlet s:enc_euc
    unlet s:enc_jis

  else "{{{4
    set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
    let &fileencodings = 'ucs-bom,iso-2022-jp-3,ucs-2le,ucs-2,' .
          \ ((&encoding ==# 'utf-8') ? 'cp932,euc-jisx0213,euc-jp' :
          \  (&encoding ==# 'cp932') ? 'utf-8,euc-jisx0213,euc-jp' :
          \                            'utf-8,cp932'                ) " 'euc-jp' 'euc-jisx0213'
  endif "}}}

  let did_encoding_settings = 1
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
]])
