function! s:goto_import(input)
  echo(a:input)
endfunction

command! -nargs=1 Gotoimport call s:goto_import(<f-args>)

" Input {{{
function! s:get_visual_selection()
  " Thanks to xolox, http://stackoverflow.com/a/6271254/309160
  " Why is this not a built-in Vim script function?
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
" }}}

" Mappings {{{
function! s:goto_import_line()
  call s:goto_import(getline('.'))
endfunction

function! s:goto_import_selection()
  call s:goto_import(s:get_visual_selection())
endfunction

nnoremap <silent> <Plug>Ngotoimport :<C-U>call <SID>goto_import_line()<CR>
vnoremap <silent> <Plug>Vgotoimport :<C-U>call <SID>goto_import_selection()<CR>

if !exists("g:goto_import_no_mappings") || ! g:goto_import_no_mappings
  nmap gi <Plug>Ngotoimport
  vmap gi <Plug>Vgotoimport
end
" }}}
