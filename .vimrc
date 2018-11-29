" show existing tab with 4 space width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" make everything less slow
set lazyredraw

" show line numbers
set relativenumber
set number

" Enable mouse usage (all modes)
set mouse=a

" encoding set necessary for older versions of vim which don't play nice with
" the following special characters
set encoding=utf-8
" show bad whitespace
set listchars=tab:▸\ ,trail:·
set list

" highlight the line containing the cursor
set cursorline

" EasyMotion plugin setup
let mapleader = "m"
let g:EasyMotion_leader_key = '<leader>'

" keyboard shortcuts
map ; :
noremap ;; ;
imap fj <Esc>

" color scheme
colorscheme apprentice

" options for ctrlspace
set nocompatible
set hidden
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'

" options for anyfold
let anyfold_activate=1
set foldlevel=10000

" options for youcompleteme
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_extra_conf_globlist = []

" options for auto-pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0

" airline
let g:airline_theme = 'angr'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview=1
set laststatus=2

" load plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'amiller27/Jenkinsfile-vim-syntax'
Plug 'vim-airline/vim-airline-themes'
Plug 'pseewald/vim-anyfold'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer' }
Plug 'Raimondi/vim-fish', { 'branch': 'indent' }
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-endwise'
call plug#end()

" Force redrawing of all the airline stuff, it doesn't like to set up the
" theme correctly without this
autocmd VimEnter *
    \ call airline#extensions#tabline#ctrlspace#invalidate() |
    \ call airline#extensions#tabline#tabs#invalidate() |
    \ call airline#load_theme() |
    \ call airline#update_statusline()

" activate powerline
"if has("python3")
"    python3 from powerline.vim import setup as powerline_setup
"    python3 powerline_setup()
"    python3 del powerline_setup
"endif

" Set buffer numbers in NetRW
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
let g:netrw_list_hide = '^\..*\.sw[op]$,.*\.pyc$'

" Set command abbreviations
ca ex Explore
ca Tc tabclose
ca Te tabedit

" Diff file against version on disk
" http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
