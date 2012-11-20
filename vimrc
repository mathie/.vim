" This is not my grandfather's vi.
set nocompatible

" A gutter on the left hand side with the current line number
set number

" Highlight the current line
set cursorline

set scrolloff=3
set linebreak
set wrap

" Enable hidden buffer, and write files out automatically (which is what I had
" TextMate set to, so what could possibly go wrong?).
set hidden
set autowriteall

" Please do syntax highlighting
syntax on
colorscheme solarized

" Store the swap files centrally so they don't pollute individual projects
set directory=~/.vim/tmp

" Indenting
" Set an indent as two spaces, convert tabs to spaces, and indentation is
" filetype-specific.
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2
filetype indent on
filetype plugin indent on

" Enhanced matching
runtime macros/matchit.vim

" Searching: incremental search, case insensitive unless caps are explicitly
" searched for and highlight the search term.
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap <C-l> :set nohlsearch<CR>

" Spelling
set spelllang=en_gb

" Folding. Default to indent, but if there's a syntax file for the current
" buffer, use syntax.
set foldmethod=indent
set foldlevel=99
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

" Command to flip from Ruby 1.8's hashrocket hash syntax to the tidier Ruby
" 1.9 version.
command! -bar -range=% NotRocket execute '<line1>,<line2>s/:\(\w\+\)\s*=>/\1:/e' . (&gdefault ? '' : 'g')

" Stick the kitchen sink in the status line
set statusline=%f%m%r%h%w\ [TYPE=%Y\ %{&ff}/%{strlen(&fenc)?&fenc:&enc}]\ [%l/%L\ (%p%%)]\ %{fugitive#statusline()}\ %{tagbar#currenttag('[%s]','')}
set laststatus=2

" OpenURL command required by rails.vim.
:command -bar -nargs=1 OpenURL :!open <args>
let g:rails_url='http://localhost:5000/'

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

" Switch on rainbow parentheses by default.
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Show up magic characters
set list!
set listchars=tab:▸\ ,eol:¬

" Rails.vim customisations
autocmd User Rails Rnavcommand factory test/factories spec/factories -glob=* -suffix=_factory.rb -default=both()

" Additional app/ directories I often use.
autocmd User Rails Rnavcommand uploader  app/uploaders  -glob=**/* -suffix=_uploader.rb  -default=both()
autocmd User Rails Rnavcommand presenter app/presenters -glob=**/* -suffix=_presenter.rb -default=both()
autocmd User Rails Rnavcommand worker    app/workers    -glob=**/* -suffix=_worker.rb    -default=both()
autocmd User Rails Rnavcommand message   app/messages   -glob=**/* -suffix=_message.rb   -default=both()

" Backbone JS files
autocmd User Rails Rnavcommand template     app/assets/templates               -glob=**/* -suffix=.jst.eco        -default=both()
autocmd User Rails Rnavcommand jsview       app/assets/javascripts/views       -glob=**/* -suffix=_view.js.coffee -default=both()
autocmd User Rails Rnavcommand jscollection app/assets/javascripts/collections -glob=**/* -suffix=.js.coffee      -default=both()
autocmd User Rails Rnavcommand jsmodel      app/assets/javascripts/models      -glob=**/* -suffix=.js.coffee      -default=both()
autocmd User Rails Rnavcommand jsrouter     app/assets/javascripts/routers     -glob=**/* -suffix=.js.coffee      -default=both()

" Map the tabularize plugin to something a little more helpful for aligning =,
" => and :.
nmap <Leader>a=       :Tabularize /[<>=]\+<CR>
vmap <Leader>a=       :Tabularize /[<>=]\+<CR>
nmap <Leader>a:       :Tabularize /:\zs/l0l1<CR>
vmap <Leader>a:       :Tabularize /:\zs/l0l1<CR>
nmap <Leader>a<Space> :Tabularize / \+/l0<CR>
vmap <Leader>a<Space> :Tabularize / \+/l0<CR>
nmap <Leader>a,       :Tabularize /,\zs/l0l1<CR>
vmap <Leader>a,       :Tabularize /,\zs/l0l1<CR>

" Switch off the arrow keys 'til I learn better.
noremap <Left>  <Nop>
noremap <Right> <Nop>
noremap <Up>    <Nop>
noremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>

" %% expands to the directory of the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" :w!! will write the file out as root instead. Handy when you forget to...
cmap w!! w !sudo tee % >/dev/null

" Select the thing you last pasted
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Prompt for a command to run
map <Leader>rp :PromptVimTmuxCommand<CR>

" Run last command executed by RunVimTmuxCommand
map <Leader>rl :RunLastVimTmuxCommand<CR>

" Inspect runner pane
map <Leader>ri :InspectVimTmuxRunner<CR>

" Close all other tmux panes in current window
map <Leader>rx :CloseVimTmuxPanes<CR>

" Interrupt any command running in the runner pane
map <Leader>rs :InterruptVimTmuxRunner<CR>

" Coffeescript ctags-style support. Mmm.
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif
let g:tagbar_compact = 1
let g:tagbar_width = 30

autocmd BufEnter * nested :call tagbar#autoopen(0)

let NERDTreeIgnore = [ '\~$', '^tmp$[[dir]]', '^log$[[dir]]', '^coverage$[[dir]]' ]

autocmd vimenter * NERDTree | wincmd p

function! rc:syncTree()
  if &modifiable && filereadable(expand('%'))
    NERDTreeFind
    normal! zz
    wincmd p
  endif
endfunction
autocmd BufEnter * call rc:syncTree()
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nmap <Leader>xr <Plug>(xmpfilter-run)
xmap <Leader>xr <Plug>(xmpfilter-run)
imap <Leader>xr <Plug>(xmpfilter-run)
nmap <Leader>xm <Plug>(xmpfilter-mark)
xmap <Leader>xm <Plug>(xmpfilter-mark)
imap <Leader>xm <Plug>(xmpfilter-mark)
