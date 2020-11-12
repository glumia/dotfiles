" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

set encoding=utf-8

" Enable filetype detection and specific behaviour
filetype plugin indent on

" Turn on syntax highlighting.
syntax on

" Allow to open another buffer even if the current one has unsaved changes
set hidden

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
"set relativenumber

" Always show the line at the bottom, even if you only have one window open.
"set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Highlight the current search
set hlsearch

" Set column highlight at char 89
" I use this value and not 80 (Linux kernel coding style) since I
" spend most of my time working in Python and use Black on my projects.
set ruler
set cc=89
set nowrap

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Unbind some useless/annoying default key bindings.
" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Force 256 color mode
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $C
    set t_Co=256
endif

" Don't litter swp files everywhere
set backupdir=~/.cache
set directory=~/.cache

" Recursively search tags file in parent directory
set tags=./tags,tags;

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>


" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
vnoremap <space> za
set foldmethod=indent   " fold based on indent level

" Vim Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'javascript',
    \ 'json',
    \ 'python',
    \ 'yaml',
\]
let g:vim_markdown_conceal = 2

" Share system's clipboard register
set clipboard=unnamed

" Command-mode bash-like movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


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

" Some useful commands (could add key bindings in the future)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convert all tabs to spaces
"set et ; retab!

" Convert all spaces to tabs
"set noet; %retab!