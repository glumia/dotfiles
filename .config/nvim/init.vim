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
  \ |   exe "normal! g`\""
  \ | endif

" Share system's clipboard register
set clipboard=unnamedplus


" Search down into subfolders
set path+=**

" Preferences for different file types {{{
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

  " Neovim LSP config
  Plug 'neovim/nvim-lspconfig'

  " Fuzzy finder
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " Theme
  Plug 'gruvbox-community/gruvbox'

  " Tmuxline (generate tmux theme according to vim's colorscheme)
  " Plug 'edkolev/tmuxline.vim'

call plug#end()


" Plugins config
let NERDTreeShowHidden=1

" Neovim LSP Config
lua << EOF
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- LSP Key mappings
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)   -- <leader>ca: Code Action
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)           -- gD: Go Declaration
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)            -- gd: Go Definition
  buf_set_keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)     -- <leader>k:  Format (buffer)
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
end


require'lspconfig'.gopls.setup{on_attach=on_attach}
require'lspconfig'.clangd.setup{on_attach=on_attach}
require'lspconfig'.pylsp.setup{
  on_attach=on_attach,
  settings={
    pylsp={
      configurationSources={"flake8", "pycodestyle"}
    }
  },
}
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.yamlls.setup{on_attach=on_attach}
require'lspconfig'.bashls.setup{on_attach=on_attach}

EOF

" Gruvbox theme
set termguicolors
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
colorscheme gruvbox
set background=light

" }}}

" Key mappings and custom commands {{{
nnoremap <SPACE> <Nop>
let mapleader = " "

nnoremap <leader>t :NERDTreeToggle<cr>

" fzf.vim
nnoremap <leader>p :GFiles<cr>
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>f :Rg 
nnoremap <leader>d :Tags<cr>

" fugitive.vim (WIP)
nnoremap <leader>b :G blame 

nnoremap <leader>l :nohlsearch<cr>
nnoremap <leader>R :source $MYVIMRC<CR>
nnoremap <leader>j :r!date<CR>o
nnoremap <c-n> :cnext<cr>
nnoremap <c-p> :cprevious<cr>

nnoremap <leader>L :LspStop<CR>:sleep 100m<CR>:e<CR>

" Convert spaces to tabs and viceversa
command TabsAreTabs :set noet | :retab!
command TabsAreSpaces :set et | :retab!

" Check spelling errors
nnoremap <leader>s :lex system('codespell ' . expand('%:p'))<cr>

" Yank path
nnoremap <leader>yp :let @+=expand("%")<CR>

" Back to normal mode from embedded terminal
tnoremap <C-\> <C-\><C-n>

" Tabs mappings
nnoremap <c-s>n :tabe<cr>
nnoremap <c-s>h :tabp<cr>
nnoremap <c-s>l :tabn<cr>

" }}}

set exrc
set secure
