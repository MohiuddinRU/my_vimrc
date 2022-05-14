set visualbell
set t_vb=

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim



call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'
Plug 'othree/html5.vim'
Plug 'valloric/youcompleteme'
Plug 'moll/vim-node'
Plug 'raimondi/delimitmate'
Plug 'mattn/emmet-vim'
Plug 'briancollins/vim-jst'
Plug 'pangloss/vim-javascript'
Plug 'robu3/vimongous'
Plug 'scrooloose/nerdtree'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-airline/vim-airline-themes'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'noahfrederick/vim-laravel'
Plug 'hdima/python-syntax'
Plug 'davidhalter/jedi-vim'
Plug 'morhetz/gruvbox'

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

let g:ycm_global_ycm_extra_conf = '$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark    " Setting dark mode


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set guifont=Consolas\ 14

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
