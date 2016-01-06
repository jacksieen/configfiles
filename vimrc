" vimrc ~/.vimrc
" Author:	Lykling
" Version:	3.0.0
" Update:	Mon Sep 21 17:44 CST 2015
" Usage: 	copy this file to home directory
" Notes:	Modified by jacksieen

autocmd! BufWritePost *.vimrc source $HOME/.vimrc

""""""""""""""""""""""
" for Vundle
""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/jackson/.vim/'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" Powerline Plugin
"Plugin 'https://github.com/powerline/powerline.git'
Plugin 'bling/vim-airline'
" Indent Guides
Plugin 'https://github.com/nathanaelkane/vim-indent-guides'
"Plugin 'http://github.com/tpope/vim-pathogen'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

""""""""""""""""""""""""
" main configuration
""""""""""""""""""""""""


colorscheme elflord
"colorscheme default
"colorscheme evening

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

"set tabstop=4
set softtabstop=2
set cindent shiftwidth=2
set autoindent shiftwidth=2
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

"filetype plugin indent on
"filetype on
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
	map <F9> :!make -s<cr>
    map <F11> :!make -n<cr>
else
	autocmd filetype c map <buffer> <F9> :!gcc -lm -g -std=c99 % -Wall -o %:r<cr>
	autocmd filetype cpp map <buffer> <F9> :!g++ -lm -g % -Wall -o %:r<cr>
	autocmd filetype pascal map <buffer> <F9> :!gpc  -g % -Wall -o%:r<cr>
	autocmd filetype c,cpp,pascal map <buffer> ;<F9> :!./%:r < %:r.tdat<cr>
	autocmd filetype python map <buffer> <F9> :!python %<cr>
	autocmd filetype expect map <buffer> <F9> :!expect %<cr>
	autocmd filetype sh map <buffer> <F9> :!sh %<cr>
	autocmd filetype asm map <buffer> <F9> :!nasm % -o%:r<cr>
	autocmd filetype java map <buffer> <F9> :!javac %<cr>
endif

autocmd filetype c map <buffer> <F10> :!gcc -lm -g -std=c99 % -Wall -o %:r;./%:r<cr>
autocmd filetype cpp map <buffer> <F10> :!g++ -lm -g % -Wall -o %:r;./%:r<cr>
autocmd filetype java map <buffer> <F10> :!javac %;java %:r<cr>

""""""""""""""""""""""
" keymaps
""""""""""""""""""""""
map <c-p> :tabprevious<cr>
map <c-n> :tabnext<cr>
map <F2> ggVG"+Y
map ;<F2> ggVG"+P
nnoremap <F12> "=strftime("%a %b %d %R %Z %Y")<cr>gP
inoremap <F12> <c-r>=strftime("%a %b %d %R %Z %Y")<cr>
"map <C-S-c> "+YThu Sep 10 20:59 CST 2015 
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


""""""""""""""""""""""
" Statusline Plugin
""""""""""""""""""""""
set laststatus=2
set t_Co=256
"let g:airline_powerline_fonts=0
"set encoding=utf8
let g:airline_left_sep = '>'
"let g:airline_left_sep = '▶'
let g:airline_right_sep = '<'
"let g:airline_right_sep = '◀'
let g:airline#extensions#whitespace#enabled = 0

""""""""""""""""""""""
" Buff && Cursor && Highlight
""""""""""""""""""""""
autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

set cursorline
hi CursorLine cterm=NONE ctermbg=darkgrey guibg=darkgrey
hi Comment cterm=NONE ctermfg=19

