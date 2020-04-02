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

" Use bash shell
set shell=bash

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
inoremap jk <Esc>

" color scheme
colorscheme apprentice

" options for ctrlspace
set nocompatible
set hidden
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'

" Vim-polyglot options
let g:polyglot_disabled = ['python']
" Python:
let g:python_highlight_space_errors = 0

" options for anyfold, enable only for files under 1M
" Copied from anyfold readme
augroup anyfold
    autocmd!
    autocmd Filetype * AnyFoldActivate
augroup END

" disable anyfold for large files
let g:LargeFile = 1000000 " file is large if size greater than 1MB
autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd! " remove AnyFoldActivate
        autocmd Filetype * setlocal foldmethod=indent " fall back to indent folding
    augroup END
endfunction

set foldlevel=10000

" options for youcompleteme
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_extra_conf_globlist = []
let g:ycm_key_invoke_completion = '<C-x>'

" options for auto-pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0

" airline
let g:airline_theme = 'angr'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#ctrlspace_show_tab_nr = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview=1
set laststatus=2

" Auto self-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" load plugins
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'amiller27/Jenkinsfile-vim-syntax'
Plug 'vim-airline/vim-airline-themes'
Plug 'pseewald/vim-anyfold'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer' }
Plug 'Raimondi/vim-fish', { 'branch': 'indent' }
Plug 'tpope/vim-endwise'
Plug 'romainl/Apprentice'
Plug 'francoiscabrol/ranger.vim'
Plug 'chiel92/vim-autoformat'
" Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
call plug#end()

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" Force redrawing of all the airline stuff, it doesn't like to set up the
" theme correctly without this
autocmd VimEnter *
            \ call airline#extensions#tabline#ctrlspace#invalidate() |
            \ call airline#extensions#tabline#tabs#invalidate() |
            \ call airline#load_theme() |
            \ call airline#update_statusline()

" Set buffer numbers in NetRW
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
let g:netrw_list_hide = '^\..*\.sw[op]$,.*\.pyc$'

" Set command abbreviations
ca ex Ranger
ca Tc tabclose
ca Te tabedit
ca gdecl YcmCompleter GoToDeclaration
ca gdef YcmCompleter GoToDefinition
ca ginc YcmCompleter GoToInclude
ca fi YcmCompleter FixIt

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

"set showcmd        " Show (partial) command in status line.
"set showmatch      " Show matching brackets.
"set ignorecase     " Do case insensitive matching
"set smartcase      " Do smart case matching
"set incsearch      " Incremental search
"set autowrite      " Automatically save before commands like :next and :make

" Add --aggressive option for autopep8
let g:formatdef_autopep8 = '"autopep8 -a -".(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? " --range ".a:firstline." ".a:lastline : "")." ".(&textwidth ? "--max-line-length=".&textwidth : "")'
let g:formatters_python = ['black', 'autopep8']

" Map ctrl-k to autoformat
map <C-k> :Autoformat<cr>

" Shortcut C-w to save and compile latex with rubber
autocmd filetype tex nnoremap <C-n> :call CompileLatex()<CR>
function! CompileLatex()
    let output = system('rubber --pdf --unsafe '.shellescape(expand('%')))
    if v:shell_error
        echo output
    endif
endfunction

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

function! DisplayColorSchemes()
    let currDir = getcwd()
    exec "cd $VIMRUNTIME/colors"
    for myCol in split(glob("*"), '\n')
        if myCol =~ '\.vim'
            let mycol = substitute(myCol, '\.vim', '', '')
            exec "colorscheme " . mycol
            exec "redraw!"
            echo "colorscheme = ". myCol
            sleep 2
        endif
    endfor
    exec "cd " . currDir
endfunction
