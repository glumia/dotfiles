" vim: fdm=marker

" Nvim settings {{{

" Mouse should scroll the editor, not the terminal.
set mouse=a

" Show line numbers.
set number

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Set column highlight at char 89.
" I use this value and not 80 (Linux kernel coding style) since I spend
" most of my time working in Python and use Black on my projects.
set cc=89

augroup nvimInit
  au!

  " Jump to the last position when reopening a file.
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup end

" Share system's clipboard register.
set clipboard=unnamed,unnamedplus

" Search down into subfolders.
set path+=**

" Enable true colors.
set termguicolors

" Praise the sun.
set background=light

" Use space as leader key.
nnoremap <SPACE> <Nop>
let mapleader = " "

" The default of 4s causes noticeable delays (affects plugins like tagbar and
" coc.nvim).
set updatetime=300

" Some language servers have issues with backup files (see
" github.com/neoclide/coc.nvim/issues/649).
set nobackup
set nowritebackup

" }}}

" Preferences for different file types {{{

augroup nvimInitFType
  au!

  autocmd FileType c setlocal cc=80
  autocmd FileType h setlocal cc=80
  autocmd FileType text setlocal cc=80
  autocmd FileType mail setlocal cc=73
  autocmd FileType gitcommit setlocal cc=73
  autocmd BufRead,BufNewFile *.mail setfiletype mail
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
  autocmd BufRead,BufNewFile *.mmark setfiletype markdown

augroup end

" }}}

" Plugins (vim-plug) {{{

call plug#begin()

  " NERDTree
  Plug 'preservim/nerdtree'

  " Tagbar
  Plug 'preservim/tagbar'

  " vim-surround: s is a text-object for delimiters
  Plug 'tpope/vim-surround'

  " vim-commentary: gc is an operator to toggle comments; gcc linewise
  Plug 'tpope/vim-commentary'

  " Extend '.' repeat capabilities
  Plug 'tpope/vim-repeat'

  " vim-fugitive - Check project's README for features
  Plug 'tpope/vim-fugitive'

  " vim-unimpaired: pairs of handy bracket mappings
  Plug 'tpope/vim-unimpaired'

  " Detect tabstop and shiftwidth automatically
  Plug 'tpope/vim-sleuth'

  " ALE - Asynchronous Linting Engine
  Plug 'dense-analysis/ale'

  " Language servers and autocompletion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Fuzzy finder
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " Markdown table of contents generator
  Plug 'mzlogin/vim-markdown-toc'

  " Github permalinks for line under cursor or selection
  Plug 'pgr0ss/vim-github-url'

  " Filetype detection and syntax highlighting for Helm templates
  Plug 'towolf/vim-helm'

  " Theme
  Plug 'gruvbox-community/gruvbox'

  " Tmuxline (generate tmux theme according to vim's colorscheme)
  " Plug 'edkolev/tmuxline.vim'

call plug#end()

" }}}

" Plugins config {{{

" NERDTree
let NERDTreeShowHidden=1

" FZF
let g:fzf_preview_window = ['up:70%:hidden', 'ctrl-/']

" ALE
let g:ale_linters_explicit = 1
let g:ale_disable_lsp = 1
let g:ale_fixers = {
\ 'python': ['ruff', 'ruff_format'],
\ 'yaml': ['prettier'],
\ 'json': ['prettier'],
\ 'html': ['prettier'],
\ 'css': ['prettier'],
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'less': ['prettier'],
\ 'arduino': ['clang-format'],
\ 'cpp': ['clang-format'],
\ 'c': ['clang-format'],
\ 'go': ['goimports'],
\ 'terraform': ['terraform'],
\ 'nginx': ['remove_trailing_lines', 'trim_whitespace'],
\ 'xml': ['xmllint'],
\ 'text': ['remove_trailing_lines', 'trim_whitespace'],
\ 'sql': ['sqlfluff'],
\}
let g:ale_linters= {
\ 'sh': ['shellcheck'],
\ 'less': ['stylelint'],
\ 'python': ['ruff'],
\}
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_python_ruff_options = '--extend-select I' " enable isort

" Gruvbox theme
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
colorscheme gruvbox

" }}}

" Language server and autocompletion {{{

" Use vim default <c-n> and <c-p> to navigate completions, tab to accept one.
inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<tab>"

" Mappings
nnoremap <silent> Ln <Plug>(coc-diagnostic-next)
noremap <silent> Lp <Plug>(coc-diagnostic-prev)
nnoremap <silent> LL :CocDiagnostics<cr>
noremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gD <Plug>(coc-declaration)
nnoremap <silent> gt <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> gI :call CocAction('showIncomingCalls')<cr>
nnoremap <silent> gO :call CocAction('showOutgoingCalls')<cr>
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <leader>ca <Plug>(coc-codeaction-cursor)
nnoremap <leader>cl <Plug>(coc-codelens-action)
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
nnoremap <silent><nowait> <space>E  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>C  :<C-u>CocList commands<cr>

" Map function and class text objects.
xnoremap if <Plug>(coc-funcobj-i)
onoremap if <Plug>(coc-funcobj-i)
xnoremap af <Plug>(coc-funcobj-a)
onoremap af <Plug>(coc-funcobj-a)
xnoremap ic <Plug>(coc-classobj-i)
onoremap ic <Plug>(coc-classobj-i)
xnoremap ac <Plug>(coc-classobj-a)
onoremap ac <Plug>(coc-classobj-a)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Language server formatting.
nnoremap <silent> <leader>K :Format<cr>:OR<cr>

" }}}

" Mappings and custom commands {{{

nnoremap <leader>w :NERDTreeFind<cr>
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>g :TagbarToggle<cr>

" fzf.vim
silent! !git rev-parse --is-inside-work-tree
if v:shell_error == 0
  nnoremap <leader>p :GFiles<cr>
else
  nnoremap <leader>p :Files<cr>
endif
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>i :Tags<cr>
nnoremap <leader>bi :BTags<cr>
nnoremap <leader>f :Rg 
nnoremap <leader>/ :BLines<cr>

" fugitive.vim
nnoremap <leader>q :G blame<cr>

" ALE Fix
nmap <leader>k <Plug>(ale_fix)

nnoremap <leader>l :nohlsearch<cr>
nnoremap <leader>R :source $MYVIMRC<CR>
nnoremap <leader>j :r!date<CR>o
nnoremap <c-n> :cnext<cr>
nnoremap <c-p> :cprevious<cr>

" Convert spaces to tabs and vice-versa
command TabsAreTabs :set noet | :retab!
command TabsAreSpaces :set et | :retab!

" Check spelling errors
silent! !command -v codespell
if v:shell_error == 0
  nnoremap <leader>s :lex system('codespell ' . expand('%:p'))<cr>:lw<cr>
else
  nnoremap <leader>s :echoerr "`codespell` is missing!"<cr>
endif

" Yank path
nnoremap <leader>yp :let @+=expand("%")<CR>

" Yank Github URL
nnoremap <leader>yu :GitHubURL<CR>
vnoremap <leader>yu :GitHubURL<CR>

" Back to normal mode from embedded terminal
tnoremap <C-\> <C-\><C-n>

" Tabs mappings
nnoremap <c-s>n :tab split<cr>
nnoremap <c-s>h :tabp<cr>
nnoremap <c-s>l :tabn<cr>
nnoremap <c-s>c :tabc<cr>

" Swap buffer
nnoremap <leader>d :b#<cr>

" }}}
