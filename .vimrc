set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'othree/html5.vim'
Plugin 'valloric/youcompleteme'
Plugin 'moll/vim-node'
Plugin 'raimondi/delimitmate'
Plugin 'mattn/emmet-vim'
Plugin 'briancollins/vim-jst'
Plugin 'pangloss/vim-javascript'
Plugin 'dbext.vim'
Plugin 'robu3/vimongous'
Plugin 'scrooloose/nerdtree'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'noahfrederick/vim-laravel'
Plugin 'hdima/python-syntax'
Plugin 'davidhalter/jedi-vim'

call vundle#end()


call plug#begin('~/.vim/plugged')

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

set number
syntax on 
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set completeopt-=preview
set nowrap
set showcmd

autocmd vimEnter *.py map <F6>  :w <CR> : !clear; python3 %; <CR>
autocmd vimEnter *.js map<F7> :w <CR> : !clear; node %; <CR>
autocmd vimEnter *.php map <F8> :w <CR> :!clear ; php % <CR>
autocmd vimEnter *.cpp map <F9> :w <CR> :!clear ; g++ --std=c++17 %; if [ -f a.out ]; then time ./a.out; rm a.out; fi <CR>
autocmd vimEnter *.java map <F10>  :w <CR> : !clear; java %; <CR>

autocmd FileType java setlocal omnifunc=javacomplete#Complete

nmap <F2> :NERDTreeToggle<CR>


let g:UltiSnipsExpandTrigger="<C-l>"
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0
let g:airline_theme='simple'

let g:ycm_global_ycm_extra_conf = '/home/crazycoder/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

