coq.vim
=======

Overview
--------
A simple Vim plugin for the Coq Proof Assistant.

Description
-----------
When editing a Coq file (filename: `*.v`) whithin Vim,
this plugin provides the function of "Go to cursol" command of CoqIde,
that is,
run `coqtop` command with lines to cursol, and
display the output in a new split window.

Usage
-----
This function is provided as Ex command:

    :CoqRunToCursol

I recommend to write a key bind in `.vimrc`, like:

    autocommand Filetype coq nnoremap ,, :CoqRunToCursol<CR>

Install
-------
Write in `.vimrc`

    NeoBundle 'tounaishouta/coq.vim'

or place this plugin somewhere and write in `.vimrc`

    set runtimepath+=path/to/this/plugin/coq.vim

License
-------
This plugin is placed in the public domain.
The indent files is a copy of http://www.vim.org/scripts/script.php?script_id=2079 .
The syntax files is a copy of http://www.vim.org/scripts/script.php?script_id=2063 .

Author
------
TOUNAI Shouta [tounai.shouta@gmail.com]

History
-------
2014 Dec 15: write README.md
2014 Dec 16: copied indent and syntax files from vim-scripts
2015 Mar 02: change user name
