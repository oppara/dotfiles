if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

" https://gist.github.com/997620
let g:endtagcommentFormat = '<!-- /%tag_name%id%class -->'
function! s:Endtagcomment()
    let reg_save = @@

    try
        silent normal vaty
    catch
        execute "normal \<Esc>"
        echohl ErrorMsg
        echo 'no match html tags'
        echohl None
        return
    endtry

    let html = @@

    let start_tag = matchstr(html, '\v(\<.{-}\>)')
    let tag_name  = matchstr(start_tag, '\v([a-zA-Z]+)')

    let id = ''
    let id_match = matchlist(start_tag, '\vid\=["'']([^"'']+)["'']')
    if exists('id_match[1]')
        let id = '#' . id_match[1]
    endif

    let class = ''
    let class_match = matchlist(start_tag, '\vclass\=["'']([^"'']+)["'']')
    if exists('class_match[1]')
        let class = '.' . join(split(class_match[1], '\v\s+'), '.')
    endif

    execute "normal `>va<\<Esc>`<"

    let comment = g:endtagcommentFormat
    let comment = substitute(comment, '%tag_name', tag_name, 'g')
    let comment = substitute(comment, '%id', id, 'g')
    let comment = substitute(comment, '%class', class, 'g')
    let @@ = comment

    normal $
    normal ""p

    let @@ = reg_save
endfunction
nnoremap <buffer><leader>e :<C-u>call <SID>Endtagcomment()<CR>


if exists('g:loaded_surround')
 let b:surround_{char2nr('1')}  = "<h1>\r</h1>"
 let b:surround_{char2nr('2')}  = "<h2>\r</h2>"
 let b:surround_{char2nr('3')}  = "<h3>\r</h3>"
 let b:surround_{char2nr('4')}  = "<h4>\r</h4>"
 let b:surround_{char2nr('5')}  = "<h5>\r</h5>"
 let b:surround_{char2nr('6')}  = "<h6>\r</h6>"

 let b:surround_{char2nr('p')} = "<p>\r</p>"
 let b:surround_{char2nr('u')} = "<ul>\r</ul>"
 let b:surround_{char2nr('o')} = "<ol>\r</ol>"
 let b:surround_{char2nr('l')} = "<li>\r</li>"
 let b:surround_{char2nr('a')}  = "<a href=\"\">\r</a>"
 let b:surround_{char2nr('A')}  = "<a href=\"\r\"></a>"
 let b:surround_{char2nr('d')} = "<div>\r</div>"
endif
