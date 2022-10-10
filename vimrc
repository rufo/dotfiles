" with inspiration from http://stevelosh.com/blog/2010/09/coming-home-to-vim/

set nocompatible


if executable("brew")
  let brew_prefix = systemlist("brew --prefix")[0]
else
  let brew_prefix = "/usr/local"
end

runtime macros/matchit.vim

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has("win32")
  call plug#begin('~/vimfiles/bundle')
else
  call plug#begin('~/.vim/bundle')
end
Plug 'scrooloose/nerdtree'
Plug 'wincent/ferret'
Plug 'tpope/vim-cucumber'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-haml'
Plug 'StanAngeloff/php.vim'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
if has('python3')
  Plug 'SirVer/ultisnips'
end
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'timcharper/textile.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-dispatch'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/dbext.vim'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-commentary'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'elixir-lang/vim-elixir'
Plug 'janko-m/vim-test'
Plug 'bswinnerton/vim-test-github'
Plug 'lambdatoast/elm.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yssl/QFEnter'
Plug 'tpope/vim-rhubarb'
Plug 'itspriddle/vim-marked'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tommcdo/vim-exchange'
Plug 'dag/vim-fish'
if executable('pbcopy') && executable('textutil') " ouputs an annoying message if it's not there
  Plug 'zerowidth/vim-copy-as-rtf'
endif
Plug 'bfontaine/Brewfile.vim'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'vim-airline/vim-airline'

if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
endif
"
" colorschemes
Plug 'chriskempson/base16-vim'
call plug#end()

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set encoding=utf-8
set scrolloff=5
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set undofile

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

nnoremap <tab> %
vnoremap <tab> %

set wrap
set linebreak
set colorcolumn=80

nnoremap j gj
nnoremap k gk

inoremap jj <ESC>
inoremap jk <ESC>

nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>[ :NERDTreeToggle<CR>
nnoremap <leader>] :NERDTreeFind<CR>
nnoremap <leader>; :if &number <Bar>
  \set relativenumber<Bar> 
    \else <Bar>
  \set number <Bar>
    \endif<cr>

nnoremap <leader>o :put ='' <Bar>put! =''<cr>

nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>j :Lines<CR>
cnoremap <C-r> :History:<CR>
nnoremap <leader>/ :History/<CR>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let test#runners = {'Ruby': ['GitHub']}
let test#strategy = 'vimterminal'

nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>

if !empty($DISABLE_TRUECOLOR) " say, old mosh
  let base16colorspace=256
elseif has("termguicolors")
  set termguicolors
  if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
end

set background=dark
try
  colorscheme base16-default-dark
catch /^Vim\%((\a\+)\)\=:E185/
  try
    colorscheme peachpuff
  catch
  endtry
endtry
hi MatchParen ctermbg=red guibg=red
au BufNewFile,BufRead *.nghaml set filetype=haml
au BufRead script/* if getline(1) =~ 'safe-ruby' | setlocal ft=ruby | endif

let g:fuzzy_ignore="vendor/**;*.png;*.jpg;*.pdf;*.xls;*.doc;*.docx;*.xlsx;coverage/**;public/pdf_previews;public/thumbnails"

set shell=/bin/sh

let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "/Users/rufo/sandbox/vimclojure-nailgun-client/ng"

if has("gui_running")
  set guifont=Iosevka\ Fixed:h15,SF\ Mono\ Medium:h13,Source\ Code\ Pro:h12
  set guioptions-=T
  autocmd FileType ruby,eruby set noballooneval
  set lines=100 columns=300
endif

let g:NERDTreeQuitOnOpen = 1

let g:CommandTFileScanner = "git"

" from http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

let g:yankring_history_dir = '~/.vim/'

" http://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev Q q

set wildignore+=.*un~
set wildignore+=.*sw?
set wildignore+=*.sassc
set wildignore+=*.sqlite3
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/.idea/*
set wildignore+=*/public/system/*
set wildignore+=*/public/pdf_previews/*
set wildignore+=*/public/thumbnails/*
set wildignore+=*/coverage/*
set wildignore+=*/script/*
set wildignore+=*.gif,*.jpg,*.png

highlight clear SignColumn

au BufRead, BufNewFile *.xls.eku setfiletype ruby

set shell=$SHELL

set mouse=a

autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


function! UpdatePowerSaving(timerId)
  if executable('pmset')
    call system("pmset -g batt | head -1 | grep 'Battery'")
    if !v:shell_error
      let g:ale_lint_delay=10000
    else
      let g:ale_lint_delay=200
    endif
  endif
endfunction

call UpdatePowerSaving(0)
let powerTimer=timer_start(10000, "UpdatePowerSaving")

let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['o', '<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<Leader><CR>']
let g:qfenter_keymap.hopen = ['<Leader><Space>']
let g:qfenter_keymap.topen = ['<Leader><Tab>']

function! SetupGithubGithub()
  let g:ale_ruby_rubocop_executable='bin/rubocop'
endfunction

autocmd BufNewFile,BufRead ~/github/github/* call SetupGithubGithub()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

if has('nvim')
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "ruby", "bash", "python", "yaml", "javascript", "css" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.ansiblels.setup{}
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
EOF
endif
