" This is not my grandfather's vi.
set nocompatible

" A gutter on the left hand side with the current line number
set number

" Highlight the current line
set cursorline

set scrolloff=3
set sidescrolloff=10
set nowrap

" Set the tmux pane title to the full path of the current file being edited.
" The idea is that this winds up in the Terminal title and allows RescueTime
" to pick up on the current document I'm working on.
set title
set titlestring=%{expand(\"%:p\")}
set titleold=
set t_ts=]2;
set t_fs=\

" Spelling
setlocal spell
setlocal spelllang=en_gb
autocmd FileType coffee setlocal nospell

" Enable hidden buffer, and write files out automatically (which is what I had
" TextMate set to, so what could possibly go wrong?).
set hidden
set autowriteall

" Please do syntax highlighting
syntax on
set background=light

" When was the last time I tried to recover something with a swapfile?
set noswapfile

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
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

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
set guifont=Source\ Code\ Pro\ Medium:h12
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
set listchars=tab:▸\ ,eol:¬,nbsp:~

let g:rails_projections = {
      \ "app/messages/*_message.rb": {
      \   "command":  "message",
      \   "affinity": "model"
      \ },
      \ "app/presenters/*_presenter.rb": {
      \   "command":  "presenter",
      \   "affinity": "model"
      \ },
      \ "app/workers/*_worker.rb": {
      \   "command": "worker"
      \ }}

let g:rails_gem_projections = {
      \ "carrierwave": {
      \   "app/uploaders/*_uploader.rb": {
      \     "command": "uploader",
      \     "affinity": "model"
      \   }
      \ },
      \ "active_model_serializers": {
      \   "app/serializers/*_serializer.rb": {
      \     "command": "serializer",
      \     "affinity": "model"
      \   }
      \ },
      \ "factory_girl_rails": {
      \   "spec/factories/*s.rb": {
      \     "command": "factory",
      \     "affinity": "model"
      \   },
      \   "test/factories/*s.rb": {
      \     "command": "factory",
      \     "affinity": "model"
      \   },
      \ },
      \ "cucumber-rails": {
      \   "features/*.feature": {
      \     "command":   "feature",
      \     "affinity":  "controller",
      \     "alternate": "features/step_definitions/%s_steps.rb"
      \   },
      \   "features/step_definitions/*_steps.rb": {
      \     "command":   "steps",
      \     "affinity":  "controller",
      \     "alternate": "features/%s.feature"
      \   }
      \ },
      \ "ember-rails": {
      \   "app/assets/javascripts/controllers/*_controller.js.coffee": {
      \     "command": "jscontroller"
      \   },
      \   "app/assets/javascripts/routes/*_route.js.coffee": {
      \     "command": "jsroute"
      \   },
      \   "app/assets/javascripts/router.js.coffee": {
      \     "command": "jsroute"
      \   },
      \   "app/assets/javascripts/helpers/*_helper.js.coffee": {
      \     "command": "jshelper"
      \   },
      \   "app/assets/javascripts/mixins/*_mixin.js.coffee": {
      \     "command": "jsmixin"
      \   },
      \   "app/assets/javascripts/views/*_view.js.coffee": {
      \     "command": "jsview"
      \   },
      \   "app/assets/javascripts/models/*.js.coffee": {
      \     "command": "jsmodel"
      \   },
      \   "app/assets/javascripts/templates/*.handlebars": {
      \     "command": "jstemplate"
      \   }
      \ },
      \ "backbone-on-rails": {
      \   "app/assets/templates/*.jst.eco": {
      \     "command": "jstemplate"
      \   },
      \   "app/assets/javascripts/views/*_view.js.coffee": {
      \     "command": "jsview"
      \   },
      \   "app/assets/javascripts/collections/*s.js.coffee": {
      \     "command":  "jscollection",
      \     "affinity": "model"
      \   },
      \   "app/assets/javascripts/models/*.js.coffee": {
      \     "command":  "jsmodel",
      \     "affinity": "model"
      \   },
      \   "app/assets/javascripts/routers/*.js.coffee": {
      \     "command": "jsrouter"
      \   }
      \ }}

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

" Shortcut keys for navigating around the command line like I'm used to
cnoremap <C-a> <Home>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

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

nmap <Leader>xr <Plug>(xmpfilter-run)
xmap <Leader>xr <Plug>(xmpfilter-run)
imap <Leader>xr <Plug>(xmpfilter-run)
nmap <Leader>xm <Plug>(xmpfilter-mark)
xmap <Leader>xm <Plug>(xmpfilter-mark)
imap <Leader>xm <Plug>(xmpfilter-mark)

" Go to the next line. Can't believe it's taken me this long to use this
" shortcut...
imap <M-o> <Esc>o

" Set the proscribed formatting (tabs!) for Go.
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist!
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Running focused specs wtih rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch rspec {spec}"

" Erlang configuration
let erlang_skel_header = { "author": "Graeme Mathieson",
      \ "owner": "Rubaidh Ltd" }
let erlang_folding = 1

" Reformat the current paragraph I'm typing.
imap <Leader>p <esc>m'gq$<C-o>a
nmap <Leader>p m'gq$<C-o>

" Save the current buffer
imap <C-s> <esc>:w<CR>a
nmap <C-s> :w<CR>
imap <Leader>w <esc>:w<CR>a
nmap <Leader>w :w<CR>

" Automatically quit if there's an existing open session (because that's what
" I always do).
augroup NoSimultaneousEdits autocmd!
  autocmd SwapExists * let v:swapchoice = 'q'
  autocmd SwapExists * echo 'Duplicate edit session, go find the original!'
  autocmd SwapExists * echohl None
  autocmd SwapExists * sleep 2
augroup END

" Highlight the 81st column of wide lines. 80 columns is more of a guideline
" than an absolute rule...
highlight ColorColumn ctermbg=green ctermfg=white
call matchadd('ColorColumn', '\%81v', 100)
