" This is not my grandfather's vi.
set nocompatible

" A gutter on the left hand side with the current line number
set number

" Highlight the current line
set cursorline

" Please do syntax highlighting
syntax on
colorscheme vividchalk

" Indenting
" Set an indent as two spaces, convert tabs to spaces, and indentation is
" filetype-specific.
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2
filetype indent on
filetype plugin indent on

" Searching: incremental search, case insensitive unless caps are explicitly
" searched for and highlight the search term.
set incsearch
set ignorecase
set smartcase
set hlsearch

" Stick the kitchen sink in the status line
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

" Tab navigation similar to Firefox/Safari
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" OpenURL command required by rails.vim.
:command -bar -nargs=1 OpenURL :!open <args>

" Make the GUI in MacVim a little more pleasant
set guifont=Consolas\ 12
set guioptions-=T
