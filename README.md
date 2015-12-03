goto-import.vim
===============
Vim plugin for opening files referenced in import statements.

Mappings
--------

You can disable this mapping by setting adding this to your .vimrc:
```
let g:gotoimport_no_mappings = 1
```

If you want to setup your own key mappings use the following:

Mapping              | Description
---------------------|-------------------------------------------------
```<Plug>Ngotoimport``` | For normal mode (uses the line under the cursor)
```<Plug>Vgotoimport``` | For visual mode (uses the selection)

For example:
```
:nmap <leader>foo <Plug>Ngotoimport
:vmap <leader>foo <Plug>Vgotoimport
```

Note: Using :noremap will not work with <Plug> mappings.
