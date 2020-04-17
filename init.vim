#!/usr/local/bin/zsh
" File: init.vim
" Author: Jeff Heaton <aloha@salt.ac>
" Last Modified Date: 2020.03.22

set encoding=utf-8

let mapleader = " "
set backspace=indent,eol,start
set directory=/tmp//
set history=50
set autowrite
set nomodeline

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

if (&t_Co > 2)
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{eslint,tslint,prettier}rc set filetype=json
augroup END

set number
set numberwidth=5

set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

set autoindent
set smartindent

set nojoinspaces

set list listchars=precedes:«,extends:»,space:·,tab:▸\
highlight WhiteSpaceBol ctermfg=8
highlight WhiteSpaceMol ctermfg=0
match WhiteSpaceBol /\s/
2match WhiteSpaceMol /\S\zs\s\ze\S/

if executable('rg')
  set grepprg=rg\ --smart-case\ --no-heading

  if executable('fzf')
    let $FZF_DEFAULT_COMMAND = 'rg --smart-case --files-with-matches --hidden'
  endif
endif

set wildmode=list:longest,full

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

nnoremap <Leader><Leader> <C-^>

let g:html_indent_inctags = "p"

set splitright
