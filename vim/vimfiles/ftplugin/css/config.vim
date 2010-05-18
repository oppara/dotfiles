if exists("b:did_ftplugin_css_config")
    finish
endif
let b:did_ftplugin_css_config = 1

" set dictionary=~/.vim/dict/css.dict


" http://d.hatena.ne.jp/secondlife/20060831/1157010796#20060831f1
" http://subtech.g.hatena.ne.jp/antipop/20060831/1157024857
nnoremap gso vi{:!~/.vim/tools/sortcss.rb<cr>
vnoremap gso i{:!~/.vim/tools/sortcss.rb<cr>
