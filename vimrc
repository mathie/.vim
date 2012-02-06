" This is not my grandfather's vi.
set nocompatible

" A gutter on the left hand side with the current line number
set number

" Highlight the current line
set cursorline

set scrolloff=3
set nowrap

" Enable hidden buffer, and write files out automatically (which is what I had
" TextMate set to, so what could possibly go wrong?).
set hidden
set autowriteall

" Please do syntax highlighting
syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

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
nmap <C-l> :set nohlsearch<CR>

" Folding. Default to indent, but if there's a syntax file for the current
" buffer, use syntax.
set foldmethod=indent
set foldcolumn=4
set foldlevel=10
autocmd Syntax * set foldmethod=syntax

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Make Ruby's completion a little more comprehensive
let g:rubycomplete_rails = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" Stick the kitchen sink in the status line
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]\ %{fugitive#statusline()}
set laststatus=2

" OpenURL command required by rails.vim.
:command -bar -nargs=1 OpenURL :!open <args>

" Make the GUI in MacVim a little more pleasant
set guifont=Menlo\ Regular:h14
set guioptions-=T

" Highlight trailing whitespace, 'cos I dislike that sort of thing.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Show up magic characters
set list!
set listchars=tab:▸\ ,eol:¬

" Rails.vim customisations
autocmd User Rails Rnavcommand factory test/factories spec/factories -glob=* -suffix=_factory.rb -default=both()
autocmd User Rails Rnavcommand uploader app/uploaders -glob=* -suffix=_uploader.rb -default=both()

" Map the tabularize plugin to something a little more helpful for aligning =
" and :.
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
