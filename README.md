vim-cabalfmt
============

Introduction
------------

This is a plugin to integrate [cabal-fmt] into your vim workflow. It will run
cabal-fmt on Cabal buffers every time they are saved.  It requires cabal-fmt be
accessible from your `$PATH`.

[cabal-fmt]: https://github.com/phadej/cabal-fmt

Installation
------------

First install cabal-fmt via Cabal, Stack or Nix:

```console
$ stack install cabal-fmt --resolver=lts-15.10   # via stack
$ cabal new-install cabal-fmt --installdir=/home/user/.local/bin # via cabal
$ nix-build -A cabal-fmt   # via nix
```

If you are using **[pathogen.vim](https://github.com/tpope/vim-pathogen)** unpack
this repository into your vim or neovim configuration directory.

```console
$ cd ~/.vim/bundle         # for vim
$ cd ~/.config/nvim/bundle # for neovim
$ git clone https://github.com/sdiehl/vim-cabalfmt.git
```

If you are using **[Vundle](https://github.com/gmarik/Vundle.vim)** add the
following to your configuration file:

```vim
"Cabal Formatting
Plugin 'sdiehl/vim-cabalfmt'
```

If you are using **[vim-plug](https://github.com/junegunn/vim-plug)** add the
following to your configuration file:

```vim
"Cabal Formatting
Plug 'sdiehl/vim-cabalfmt'
```

Configuration
-------------

*The default settings will work fine out of the box without any aditional
configuration*.

If you have a non-standard `$PATH` then set `g:cabalfmt_command` Vim variable to
the location of the cabal-fmt binary.

The specific flags for cabal-fmt can be configured by changing the Vim variable
`g:cabalfmt_options`. For example to use two space indentation.

```vim
let g:cabalfmt_options=["--indent 2"]
```

If instead of formatting on save, you wish to bind formatting to a specific
keypress add the following to your `.vimrc` or `init.vim`.  For example to bind
file formatting to the key sequence <kbd>t</kbd><kbd>f</kbd> use:

```vim
nnoremap tf :call RunCabal()<CR>
```

To manually install the formatter on a specific file extension invoke
`RunCabal()` as a BufWritePre hook.

```vim
autocmd BufWritePre *.cabal :call RunCabal()
```

License
-------

MIT License
Copyright (c) 2020, Stephen Diehl
