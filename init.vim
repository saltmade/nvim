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
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter *
        \ if &number |
        \   set relativenumber |
        \ endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave *
        \ if &number |
        \   set norelativenumber |
        \ endif
augroup END

set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

set autoindent
set smartindent

set nojoinspaces

set list listchars=precedes:«,extends:»,space:·,tab:▸\

augroup WhiteSpaceHighlight
  autocmd!
  highlight WhiteSpaceBol ctermfg=8
  highlight WhiteSpaceMol ctermfg=0
  autocmd VimEnter,Winenter * match WhiteSpaceBol /\s/ | 2match WhiteSpaceMol /\S\zs\s\ze\S/
augroup END

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

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

vnoremap y "+y

set spellfile=$XDG_CONFIG_HOME/nvim/.vim-spell-en.utf-8.add

augroup filetype_markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal complete+=kspell
  " TODO Add thesaurus plugin
augroup END

set diffopt+=vertical

augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

nnoremap x "_x

nnoremap <Leader>/<Esc> :let @/=""<CR>:<Esc>

packadd minpac

if !exists('*minpac#init')
  finish
endif

call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
