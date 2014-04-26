" vimrc ~/.vimrc
" Author:	Lykling
" Version:	2.0.1
" Update:	Fri Jan 25 01:51:17 CST 2013
" Usage: 	copy this file to home directory
" Notes:	Modified a little by jacksieen, 2nd, Sept, 2013

autocmd! BufWritePost *.vimrc source $HOME/.vimrc

colorscheme elflord
"colorscheme default
"colorscheme evening
set nocompatible

set bsdir=buffer
set autochdir

set enc=utf-8
set fenc=utf-8
set fencs=utf-8,ucs-bom,gb18030,gb2312,gbk,cp936

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

syntax enable
syntax on

set ai
set si
set cindent

set nu
set hlsearch
set hls is
set incsearch
set ru

set tabstop=4
set softtabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
"set mouse=a
set mouse=h
set backspace=2
set expandtab

set foldmethod=indent
set foldlevel=1
set foldclose=
set foldnestmax=2
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set comments=://
set comments=:s1:/*,mb:*,ex0:/

set tags=./tags,./../tags,./**/tags

set fileformats=unix,dos

set cmdheight=1

filetype plugin indent on
filetype on
autocmd BufRead,BufNewFile *     if &ft=='html' | set ft=htmldjango | endif
""""""""""""""""""""""
" comments
""""""""""""""""""""""
autocmd filetype c,cpp,java,javascript,css,php map ;/ :s/\( *<tab>*\)\(.*\)/\1\/* \2 *\//<cr>:noh<cr>
autocmd filetype c,cpp,java,javascript,css,php map ;? :s/\/\* \(.*\) \*\//\1/<cr>:noh<cr>
autocmd filetype xml,html,htmldjango map <buffer> ;/ :s/\( *<tab>*\)\(.*\)/\1<!-- \2 -->/<cr>:noh<cr>
autocmd filetype xml,html,htmldjango map <buffer> ;? :s/<!-- \(.*\) -->/\1/<cr>:noh<cr>
autocmd filetype sh,python map <buffer> ;/ :s/\( *<tab>*\)/\1#/<cr>:noh<cr>
autocmd filetype sh,python map <buffer> ;? :s/\( *<tab>*\)#/\1/<cr>:noh<cr>
autocmd filetype vim map <buffer> ;/ :s/\( *<tab>*\)/\1"/<cr>:noh<cr>
autocmd filetype vim map <buffer> ;? :s/\( *<tab>*\)"/\1/<cr>:noh<cr>
autocmd filetype tex map <buffer> ;/ :s/\(.*\)/\%\1/<cr>:noh<cr>
autocmd filetype tex map <buffer> ;? :s/^%\(.*\)/\1/<cr>:noh<cr>
autocmd filetype c,cpp,java,css,javascript.php imap <buffer> {} {<cr>}<up><end><cr>
autocmd filetype c,cpp,java,css,javascript,php imap <buffer> ;/ /*  */<left><left><left>
""""""""""""""""""""""
" program test
""""""""""""""""""""""
if filereadable("Makefile")
	map <F9> :!make<cr>
else
	autocmd filetype c map <buffer> <F9> :!gcc -lm -g % -Wall -o %:r<cr>
	autocmd filetype cpp map <buffer> <F9> :!g++ -lm -g % -Wall -o %:r<cr>
	autocmd filetype pascal map <buffer> <F9> :!gpc  -g % -Wall -o%:r<cr>
	autocmd filetype c,cpp,pascal map <buffer> ;<F9> :!./%:r < %:r.tdat<cr>
	autocmd filetype python map <buffer> <F9> :!python %<cr>
	autocmd filetype expect map <buffer> <F9> :!expect %<cr>
	autocmd filetype sh map <buffer> <F9> :!sh %<cr>
	autocmd filetype asm map <buffer> <F9> :!nasm % -o%:r<cr>
	autocmd filetype java map <buffer> <F9> :!javac %<cr>
endif

autocmd filetype c map <buffer> <F10> :!gcc -lm -g % -Wall -o %:r;./%:r<cr>
autocmd filetype cpp map <buffer> <F10> :!g++ -lm -g % -Wall -o %:r;./%:r<cr>
autocmd filetype java map <buffer> <F10> :!javac %;java %:r<cr>

""""""""""""""""""""""
" keymaps
""""""""""""""""""""""
map <c-p> :tabprevious<cr>
map <c-n> :tabnext<cr>
map <F2> ggVG"+Y
map ;<F2> ggVG"+P
"map <C-S-c> "+Y 
"map <C-S-v> "+P 
"map ;/ <esc>:s/^.*$/\/* & *\/<cr>:noh<cr>
"map ;? <esc>:s/^\(<tab>*\)\/\* \(.*\) \*\/\(.*\)/\1\2\3/<cr>:noh<cr>
"map ;/ :s/\( *<tab>*\)\(.*\)/\1\/* \2 *\//<cr>:noh<cr>
"map ;? :s/\/\* \(.*\) \*\//\1/<cr>:noh<cr>

""""""""""""""""""""""
" keymap for split
""""""""""""""""""""""
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l


""""""""""""""""""""""
" brackets
""""""""""""""""""""""
imap "" ""<left>
imap {} {}<left>
imap () ()<left>
imap [] []<left>
imap '' ''<left>
imap <> <><left>

autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

set cursorline
hi CursorLine cterm=NONE ctermbg=blue  guibg=blue

