function! s:goto_import(input)
  let file_path = s:extract_file_path(a:input)
  let full_path = s:pick_file(file_path)

  if len(full_path) > 1
    execute 'e ' . full_path
  end
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

" Extraction {{{
function! s:extract_file_path(input)
  let file_path = a:input
  let rails_js_require = matchlist(a:input, '\/\/= require \(.*\)')
  let rails_coffee_require = matchlist(a:input, '#= require \(.*\)')
  let single_quotes = matchlist(a:input, '''\(.\{-}\)''')
  let double_quotes = matchlist(a:input, '"\(.\{-}\)"')

  if len(rails_js_require) > 0
    let file_path = rails_js_require[1]
  elseif len(rails_coffee_require) > 0
    let file_path = rails_coffee_require[1]
  elseif len(single_quotes) > 0
    let file_path = single_quotes[1]
  elseif len(double_quotes) > 0
    let file_path = double_quotes[1]
  end

  return file_path
endfunction
" }}}

" Files {{{
function! s:pick_file(file_path)
  let current_path = expand('%:p:h')
  let extension = expand('%:e')
  let full_path = current_path . '/' . a:file_path

  if filereadable(full_path . '.' . extension)
    return full_path . '.' . extension
  elseif filereadable(expand(full_path . '.**'))
    return expand(full_path . '.**')
  elseif len(expand(full_path . '.**')) > 1
    call s:build_quickfix_list(expand(full_path . '.**'))
    return
  end

  return full_path . '.' . extension
endfunction

function! s:build_quickfix_list(files)
  let file_list = split(a:files, '\n')
  let list = []

  for file in file_list
    let list = list + [{ 'filename': file, 'lnum': 0 }]
  endfor

  call setqflist(list)
  copen
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
