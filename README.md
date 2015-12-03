goto-import.vim
===============
Vim plugin for opening files referenced in import statements.

Usage
-----

Currently the plugin only supports relative file paths. It assumes that the
path doesn't include an extension.

The built in mapping allows triggering the plugin using `gi` from normal or
visual mode. The mnemonic for this is "goto import", similar to `gf`.

You can also use command mode:
```
:Gotoimport ../my_super_fine_import
```

Mappings
--------

You can disable the mapping by adding this to your .vimrc:
```
let g:goto_import_no_mappings = 1
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
