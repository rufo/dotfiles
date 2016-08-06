" with inspiration from http://stevelosh.com/blog/2010/09/coming-home-to-vim/

set nocompatible
filetype off

runtime macros/matchit.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'mileszs/ack.vim'
Plugin 'wincent/command-t'
Plugin 'tpope/vim-cucumber'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-haml'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'StanAngeloff/php.vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'tpope/vim-rails'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-repeat'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'timcharper/textile.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-endwise'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'
Plugin 'pangloss/vim-javascript'
Plugin 'ap/vim-css-color'
Plugin 'gcmt/wildfire.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-sleuth'
Plugin 'vim-scripts/dbext.vim'
Plugin 'file:///Users/rufo/sandbox/psl.vim'
Plugin 'chrisbra/csv.vim'
" Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-commentary'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'elixir-lang/vim-elixir'

call vundle#end()
filetype plugin indent on

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
set colorcolumn=85

nnoremap j gj
nnoremap k gk

"nnoremap ; :
"vnoremap ; :

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

"nnoremap <leader>b :buffers<CR>:buffer<Space>

syntax on
filetype plugin indent on
set background=dark
set guifont=Source\ Code\ Pro:h12
set guioptions-=T
colorscheme base16-default
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

"let g:EasyMotion_leader_key = '<Leader>m'

"nmap <silent> <Leader>p :CommandT<CR>

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

highlight clear SignColumn

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "Dispatch rspec --drb {spec}"

au BufRead, BufNewFile *.xls.eku setfiletype ruby

set shell=$SHELL

set mouse=a

autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif

