""""""""""""""""""""""""""""""""""""""""""""
"
"  Last updated on Wed, 27 Jul 2016 16:17:03 +0800
"
"
""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off


" for plugins "
set rtp+=~/.vim/Vundle.vim
call vundle#begin('~/.vim/')

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""
" Base setting
"""""""""""""""""""""""""""""""""""""""""""

colorscheme elflord

set bsdir=buffer
set autochdir

set enc=utf-8
set fenc=utf-8
set fencs=utf-8,gb18030,gb2312,gbk,cp936,ucs-bom

syntax on
set comments=://
set comments=:s1:/*,mb:*,ex0:/
set tags=./tags,./../tags,./**/tags

set ai
set si
set cindent

set nu
set ru
set hlsearch
set incsearch
set hls is

set softtabstop=4
set shiftwidth=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
set mouse=h
set backspace=2
set et


set foldmethod=indent
set foldlevel=1
set foldclose=
set foldnestmax=2
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set fileformats=unix,dos

autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif


set laststatus=2
set t_Co=256
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline#ectension#whitespace#enabled = 0


"""""""""""""""""""""""""""""""""""""""""""""""""
" For Comments
"""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *  if &ft=='html' | set ft=htmldjango | endif
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
"autocmd filetype c,cpp,java,css,javascript.php imap <buffer> {} {<cr>}<up><end><cr>
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
    autocmd filetype go map <buffer> <F9> :!go build %<cr>
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
autocmd filetype go map <buffer> <F10> :!go run %<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <c-p> :tabprevious<cr>
map <c-n> :tabnext<cr>
nnoremap <F12> "=strftime("%a, %d %b %Y %H:%M:%S %z")<cr>gP
inoremap <F12> <c-r>=strftime("%a, %d %b %Y %H:%M:%S %z")<cr>
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <F4> :noh<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pairs matching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! AutoPair(open, close)
  "let line = getline('.')
  "if col('.') > strlen(line) || line[col('.') - 1] == ' '
    "return a:open.a:close."\<ESC>i"
  "else
    "return a:open
  "endif
"endf

function! LPair(open,close)
    return a:open.a:close."\<ESC>i"
endf


function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

"function! SamePair(char)
  "let line = getline('.')
  "if col('.') > strlen(line) || line[col('.') - 1] == ' '
    "return a:char.a:char."\<ESC>i"
  "elseif line[col('.') - 1] == a:char
    "return "\<Right>"
  "else
    "return a:char
  "endif
"endf

function! SPair(char)
    let line = getline('.')
    if line[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<ESC>i"
endf

inoremap ( <c-r>=LPair('(', ')')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=LPair('{', '}')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=LPair('[', ']')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap < <c-r>=LPair('<', '>')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
inoremap " <c-r>=SPair('"')<CR>
inoremap ' <c-r>=SPair("'")<CR>
inoremap ` <c-r>=SPair('`')<CR>

""""""""""""""""""""""""""""""""""""""""""
" Per filetype setting
""""""""""""""""""""""""""""""""""""""""""
autocmd filetype c,cpp,sh,go,java,javascript set sts=2 sw=2
autocmd filetype python set sts=4

autocmd filetype xml,hmtl,htmldjango inoremap < <c-r>=LPair('<','>')<CR>
autocmd filetype xml,hmtl,htmldjango inoremap > <c-r>=ClosePair('>')<CR>
autocmd filetype c,go,cpp,java,css,javascript,php imap <buffer> {} {<cr>}<up><end><cr>

autocmd BufNewFile * call CTitle()
"autocmd BufNewFile * exec ";call CTitle()"
func! CTitle()
    "set python env and coding for python file"
    if &ft=='python'
        call append(0,"#!/usr/bin/env python")
        call append(1,"# coding=utf8")

    endif
endfunc



set cursorline
" set cursorline color "
"hi CursorLine cterm=NONE ctermbg=darkgrey guibg=darkgrey
"hi CursorLine cterm=NONE ctermbg=NONE guibg=NONE
" set comment color under color theme"
hi Comment cterm=NONE ctermfg=19
