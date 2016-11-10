" with inspiration from http://stevelosh.com/blog/2010/09/coming-home-to-vim/

set nocompatible

runtime macros/matchit.vim

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

if has("win32")
  call plug#begin('~/vimfiles/bundle')
else
  call plug#begin('~/.vim/bundle')
end
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'wincent/command-t'
Plug 'tpope/vim-cucumber'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-haml'
Plug 'StanAngeloff/php.vim'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'tpope/vim-rails'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-repeat'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
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
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/dbext.vim'
Plug 'file:///Users/rufo/sandbox/psl.vim'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-commentary'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'elixir-lang/vim-elixir'
Plug 'janko-m/vim-test'
Plug 'lambdatoast/elm.vim'
Plug 'ConradIrwin/vim-bracketed-paste'

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

nnoremap <leader>r :CommandTFlush
nnoremap <leader>p :CommandT<CR>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>

set background=dark
set guifont=Source\ Code\ Pro:h12
set guioptions-=T
colorscheme base16-default-dark
hi MatchParen ctermbg=red guibg=red
au BufNewFile,BufRead *.nghaml set filetype=haml

let g:fuzzy_ignore="vendor/**;*.png;*.jpg;*.pdf;*.xls;*.doc;*.docx;*.xlsx;coverage/**;public/pdf_previews;public/thumbnails"

set shell=/bin/sh

let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "/Users/rufo/sandbox/vimclojure-nailgun-client/ng"

if has("gui_running")
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

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if has("termguicolors")
  set termguicolors
end
