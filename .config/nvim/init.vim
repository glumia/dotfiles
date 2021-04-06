" Show line numbers.
set number

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Set column highlight at char 89
" I use this value and not 80 (Linux kernel coding style) since I
" spend most of my time working in Python and use Black on my projects.
set ruler
set cc=89
set nowrap

" Mouse should scroll the editor, not the terminal
set mouse=a

" Jump to the last position when reopening a file
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Fix for messed colors on tmux
" Source - https://unix.stackexchange.com/questions/348771
if $TERM == "screen-256color" || $TERM == "xterm-256color"
    set background=light
endif

" Share system's clipboard register
set clipboard=unnamedplus

" Preferences for different file types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType c setlocal noet ts=8 sw=8 tw=80 cc=80
autocmd FileType h setlocal noet ts=8 sw=8 tw=80 cc=80
autocmd FileType cpp setlocal noet ts=8 sw=8 tw=80
autocmd FileType s setlocal noet ts=8 sw=8
autocmd FileType go setlocal noet ts=4 sw=4
autocmd FileType sh setlocal noet ts=4 sw=4
autocmd BufRead,BufNewFile *.js setlocal et ts=2 sw=2
autocmd FileType html setlocal et ts=2 sw=2
autocmd FileType yaml setlocal et ts=2 sw=2
autocmd FileType markdown setlocal tw=80 et ts=2 sw=2
autocmd FileType text setlocal tw=80 cc=80
autocmd FileType typescript setlocal et ts=2 sw=2
autocmd FileType python setlocal et ts=4 sw=4
autocmd FileType tex hi Error ctermbg=NONE
autocmd FileType mail setlocal noautoindent cc=73
augroup filetypedetect
  autocmd BufRead,BufNewFile *.mail setfiletype mail
augroup filetypedetect
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup filetypedetect
  autocmd BufRead,BufNewFile *.mmark setfiletype markdown

" Key mappings
let mapleader = '\'
nnoremap <leader>rt :set noet <bar> :%retab!<cr> " Convert spaces to tabs
nnoremap <leader>nrt :set et <bar> :retab!<cr> " Convert tabs to spaces
