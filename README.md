coq.vim
=======

Overview
--------
A simple Vim plugin for the Coq Proof Assistant.

Description
-----------
When editing a coq file (filename: `*.v`) whithin Vim,
this plugin provides the function of "Go to cursol" command of CoqIde,
that is, get lines to the cursol line,
run `coqtop` command with the lines,
analize the output from `coqtop`, and
display it a new split window.

Usage
-----
The above function is provided as Ex command:

    :CoqRunToCursol

I recommend to write a key bind in `.vimrc`, like:

    autocommand Filetype coq nnoremap ,, :CoqRunToCursol<CR>

Install
-------
Write in `.vimrc`

    NeoBundle 'IjvLHsoZ6L/coq.vim'

or place this plugin somewhere and write in `.vimrc`

    set runtimepath+=path/to/this/plugin/coq.vim

License
-------
This plugin is placed in the public domain.

Author
------
IjvLHsoZ6L [tounai.shouta@gmail.com]

History
-------
2014 Dec 15: write README.md
