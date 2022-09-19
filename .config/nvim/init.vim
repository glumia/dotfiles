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

  " Jump to the last position when reopening a file
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

" }}}

" Preferences for different file types {{{

augroup nvimInitFType
  au!

  autocmd FileType c setlocal et ts=2 sw=2 tw=80 cc=80
  autocmd FileType h setlocal et ts=2 sw=2 tw=80 cc=80
  autocmd FileType cpp setlocal et ts=2 sw=2 tw=80
  autocmd FileType s setlocal noet ts=8 sw=8
  autocmd FileType go setlocal noet ts=4 sw=4 makeprg=go\ build
  autocmd FileType sh setlocal noet ts=4 sw=4
  autocmd BufRead,BufNewFile *.js setlocal et ts=2 sw=2
  autocmd FileType html setlocal et ts=2 sw=2
  autocmd FileType yaml setlocal et ts=2 sw=2
  autocmd FileType vim setlocal et ts=2 sw=2
  autocmd FileType markdown setlocal tw=80 et ts=2 sw=2
  autocmd FileType text setlocal tw=80 cc=80
  autocmd FileType typescript setlocal et ts=2 sw=2
  autocmd FileType python setlocal et ts=4 sw=4
  autocmd FileType tex hi Error ctermbg=NONE
  autocmd FileType mail setlocal noautoindent cc=73
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

  " nvim lua (kind of) stdlib - required by diffview.nvim
  Plug 'nvim-lua/plenary.nvim'

  " diffview.nvim: review changes within vim  
  Plug 'sindrets/diffview.nvim'

  " vim-unimpaired: pairs of handy bracket mappings
  Plug 'tpope/vim-unimpaired'

  " ALE - Asynchronous Linting Engine
  Plug 'dense-analysis/ale'

  " Neovim LSP config
  Plug 'neovim/nvim-lspconfig'

  " Fuzzy finder
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " Markdown table of contents generator
  Plug 'mzlogin/vim-markdown-toc'

  " Github permalinks for line under cursor or selection
  Plug 'pgr0ss/vim-github-url'

  " Theme
  Plug 'gruvbox-community/gruvbox'

  " Tmuxline (generate tmux theme according to vim's colorscheme)
  " Plug 'edkolev/tmuxline.vim'

call plug#end()


" NERDTree config
let NERDTreeShowHidden=1

" FZF Config
let g:fzf_preview_window = ['up:70%:hidden', 'ctrl-/']

" ALE Config
let g:ale_linters_explicit = 1
let g:ale_disable_lsp = 1
let g:ale_fixers = {
\ 'python': ['isort', 'black'],
\ 'yaml': ['prettier'],
\ 'json': ['prettier'],
\ 'html': ['prettier'],
\ 'css': ['prettier'],
\ 'arduino': ['clang-format'],
\ 'cpp': ['clang-format'],
\ 'c': ['clang-format'],
\ 'go': ['goimports'],
\ 'terraform': ['terraform'],
\}
let g:ale_linters= {
\ 'sh': ['shellcheck'],
\ 'markdown': ['proselint'],
\}
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

" Gruvbox theme
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
colorscheme gruvbox

" diffview.nvim
lua << EOF
require("diffview").setup({
  use_icons = false,
  signs = {
    fold_closed = "▸",
    fold_open = "▾",
    done = "✓",
  },
  file_panel = {
    win_config = {
      position = "bottom",
      height = 10, -- Same as quickfix list
    },
  },
})
EOF

" }}}

" LSP config {{{
lua << EOF
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- LSP Key mappings
  buf_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)           -- ca: Code Action
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)           -- gD: Go Declaration
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)            -- gd: Go Definition
  --buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)     -- <leader>k:  Format (buffer)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)                  -- K:  Help
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)        -- gi: Go Implementation
  buf_set_keymap('n', 'gu', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)        -- gu: Go Users (users of this obj)
  buf_set_keymap('n', 'gU', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)        -- gU: Go Used  (used by this obj)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)            -- gr: Go References
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)        -- <leader>rn: ReName
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)       -- gt: Go Type
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)     -- C-k:  Help

  buf_set_keymap('n', 'LL', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)         -- LL: Location List
  buf_set_keymap('n', 'Ln', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)          -- Ln: Diagnostics Next
  buf_set_keymap('n', 'Lp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)          -- Lp: Diagnostics Previous
  buf_set_keymap('n', 'Lk', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)         -- Lk: Diagnostics Help

  -- Override code formatting with eslint
  for _, value in ipairs({'javascript','javascriptreact','javascript.jsx','typescript',
    'typescriptreact','typescript.tsx'}) do
    if vim.bo.filetype == value then
      buf_set_keymap("n", "<leader>k", "<cmd>EslintFixAll<CR>", opts)
    end
  end
end

lspconfig.gopls.setup{on_attach=on_attach}
lspconfig.clangd.setup{on_attach=on_attach}
lspconfig.pyright.setup{on_attach=on_attach}
lspconfig.tsserver.setup{on_attach=on_attach}
lspconfig.eslint.setup{on_attach=on_attach}
lspconfig.yamlls.setup{on_attach=on_attach}
lspconfig.stylelint_lsp.setup{
  on_attach=on_attach,
  settings = {
    stylelintplus = {
      autoFixOnFormat=true,
    },
  },
}
EOF
" }}}

" Key mappings and custom commands {{{

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
nnoremap <leader>f :Rg 

" fugitive.vim
nnoremap <leader>q :G blame<cr>

" diffview.nvim
nnoremap <leader>D :DiffviewOpen<cr>

" ALE (note: this is sometimes overridden by language servers)
nmap <leader>k <Plug>(ale_fix)

nnoremap <leader>l :nohlsearch<cr>
nnoremap <leader>R :source $MYVIMRC<CR>
nnoremap <leader>j :r!date<CR>o
nnoremap <c-n> :cnext<cr>
nnoremap <c-p> :cprevious<cr>

" LSP Restart
nnoremap <leader>L :LspStop<CR>:sleep 100m<CR>:e<CR>

" Convert spaces to tabs and viceversa
command TabsAreTabs :set noet | :retab!
command TabsAreSpaces :set et | :retab!

" Check spelling errors
nnoremap <leader>s :lex system('codespell ' . expand('%:p'))<cr>:lw<cr>

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

" No need to stretch to exit
inoremap jk <esc>

" Swap buffer
nnoremap <leader>d :b#<cr>

" }}}
