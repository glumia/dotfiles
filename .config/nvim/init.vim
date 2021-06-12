" vim: fdm=marker

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

" Mouse should scroll the editor, not the terminal
set mouse=a

" Jump to the last position when reopening a file
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |	exe "normal! g`\""
  \ | endif

" Share system's clipboard register
set clipboard=unnamedplus

" Search down into subfolders
set path+=**

" Preferences for different file types {{{
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
" }}}


" Plugins (vim-plug) {{{
call plug#begin()

  " NERDTree
  Plug 'preservim/nerdtree'

  " Editorconfig plugin
  Plug 'editorconfig/editorconfig-vim'

  " vim-surround: s is a text-object for delimiters
  Plug 'tpope/vim-surround'

  " vim-commentary: gc is an operator to toggle comments; gcc linewise
  Plug 'tpope/vim-commentary'

  " Extend '.' repeat capabilities
  Plug 'tpope/vim-repeat'

  " vim-fugitive - Check project's README for features
  Plug 'tpope/vim-fugitive'

  " Sensitive vim defaults - Not needed since I'm on neovim, but I put it
  " here anyway just in case I'm forced to use vim.
  "Plug 'tpope/vim-sensible'

  " ALE Lint Engine
  Plug 'dense-analysis/ale'

  " Fuzzy finder
  Plug 'junegunn/fzf'

  " Go Plugin
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " Theme
  Plug 'gruvbox-community/gruvbox'

  " Tmuxline (generate tmux theme according to vim's colorscheme)
  " Plug 'edkolev/tmuxline.vim'

call plug#end()


" Plugins config
let NERDTreeShowHidden=1

" ALE Config
let g:ale_linters= {
\   'python': ['flake8', 'pylint', 'pyls'],
\}
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

let g:ale_fixers = {
\   'python': [
\       'isort',
\       'black',
\   ],
\   'yaml': [
\       'prettier',
\   ],
\   'json': [
\       'prettier',
\   ],
\}
let g:ale_python_isort_options = '--profile black'
let g:ale_python_flake8_options = '--ignore=E501,E266,W503'


" Gruvbox theme
set termguicolors
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
colorscheme gruvbox
set background=light



" }}}


" Key mappings
nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap <leader>rt :set noet <bar> :%retab!<cr> " Convert spaces to tabs
nnoremap <leader>nrt :set et <bar> :retab!<cr> " Convert tabs to spaces
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>p :FZF<cr>
nnoremap <leader>l :nohlsearch<cr>
nnoremap <leader>R :source $MYVIMRC<CR>
nmap <leader>k <Plug>(ale_fix)
nnoremap <leader>j :r!date<CR>o
