
" syntax off
" colorscheme aqua
" colorscheme anokha
set nocompatible
colorscheme evening
syntax on
set ignorecase
set tabstop=3
set shiftwidth=3
set autoindent
set showmode
set noshowmatch
set report=1
set ruler
set nowrap
set sidescroll=10
" always show 2 lines of context at top/bottom when scrolling
set scrolloff=2

" no longer creates backup files
set nobackup

" CTRL-N will un-highlight searches
nmap <silent> <C-N> :silent noh
" make the search text something I can see
" highlight Search      term=reverse ctermbg=2 guibg=Yellow

" goto top - press g twice
map g 1G
map q ebi'Ea', ldweB
map C z.
" F2 key positions current line at top of screen
map #2 zt
" F3 key positions current line in middle of screen
map #3 z.
" F4 key positions current line at bottom of screen
map #4 zb
" line numbers on
map #7 :set number
" line numbers off
map #9 :set nonumber

