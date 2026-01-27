set visualbell
set t_vb=
let mapleader = "," 


let g:loaded_matchparen = 1

set nocompatible
filetype off
set filetype=unix
syntax sync fromstart
syntax sync minlines=10000

set gp=git\ grep\ -n

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'morhetz/gruvbox'
Plug 'cjuniet/clang-format.vim'

Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'mechatroner/rainbow_csv'
Plug 'tpope/vim-ragtag'

Plug 'othree/javascript-libraries-syntax.vim'
"vue support
Plug 'neoclide/coc-vetur'
Plug 'posva/vim-vue'

Plug 'josa42/coc-sh'
Plug 'tpope/vim-surround'

"python coc
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'hdima/python-syntax'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dbakker/vim-projectroot'
Plug 'mileszs/ack.vim'
"Plug 'puremourning/vimspector'
Plug 'yaegassy/coc-blade', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html'
Plug 'sheerun/vim-polyglot'

Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

Plug 'puremourning/vimspector'
Plug 'preservim/nerdcommenter'

Plug 'prisma/vim-prisma'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

call plug#end()

let g:lsc_auto_map = v:true

let g:ackprg = 'ag --nogroup --nocolor --column'

nnoremap <key> *``
nnoremap <anotherkey> #``

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

au FileType php let b:coc_root_patterns = ['.git', '.env', 'composer.json', 'artisan']

"searching
let g:ackprg = 'ag --nogroup --nocolor --column'

" Use the stdio version of OmniSharp-roslyn - this is the default
"
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
let g:OmniSharp_server_stdio = 1

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

let g:ale_disable_lsp = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

set number
syntax on 
set re=1
filetype plugin indent on
filetype plugin on

set tabstop=4
set shiftwidth=4
set expandtab
set completeopt-=preview
set nowrap
set showcmd

"autocmd vimEnter *.js map <F6>  :w <CR> : !clear; node %; <CR>
"autocmd vimEnter *.sh map <F7>  :w <CR> : !clear; bash %; <CR>
"autocmd vimEnter *.py map <F8>  :w <CR> : !clear; python3 %; <CR>
"autocmd vimEnter *.cpp map <F9> :w <CR> :!clear ; /usr/bin/g++ --std=c++17 %; if [ -f a.out ]; then time ./a.out; rm a.out; fi <CR>
""autocmd vimEnter *.go map <F9> :w <CR> :!clear ;  time go run % <CR>
"autocmd vimEnter *.java map <F10>  :w <CR> : !clear; !javac %; :!java -cp %:p:h %:t:r<CR>

function! RunFile()
  " Save the current file first
  write

  " Get file info
  let l:ext = expand('%:e')      " file extension
  let l:file = shellescape(expand('%'))       " full filename (escaped)
  let l:basename = expand('%:t:r') " file name without extension
  let l:dir = shellescape(expand('%:p:h'))    " directory path (escaped)

  " Choose command based on extension
  if l:ext ==# 'py'
    execute '!clear && time python3 ' . l:file
  elseif l:ext ==# 'js'
    execute '!clear && time node ' . l:file
  elseif l:ext ==# 'sh'
    execute '!clear && time bash ' . l:file
  elseif l:ext ==# 'cpp'
    execute '!clear && g++ --std=c++17 ' . l:file . ' -o /tmp/a.out && time /tmp/a.out && rm /tmp/a.out'
  elseif l:ext ==# 'c'
    execute '!clear && gcc ' . l:file . ' -o /tmp/a.out && time /tmp/a.out && rm /tmp/a.out'
  elseif l:ext ==# 'java'
    execute '!clear && javac ' . l:file . ' && time java -cp ' . l:dir . ' ' . l:basename
  elseif l:ext ==# 'go'
    execute '!clear && time go run ' . l:file
  elseif l:ext ==# 'rb'
    execute '!clear && time ruby ' . l:file
  elseif l:ext ==# 'pl'
    execute '!clear && time perl ' . l:file
  elseif l:ext ==# 'php'
    execute '!clear && time php ' . l:file
  elseif l:ext ==# 'lua'
    execute '!clear && time lua ' . l:file
  elseif l:ext ==# 'rs'
    execute '!clear && rustc ' . l:file . ' -o /tmp/rust_out && time /tmp/rust_out && rm /tmp/rust_out'
  elseif l:ext ==# 'ts'
    execute '!clear && time ts-node ' . l:file
  elseif l:ext ==# 'dart'
    execute '!clear && time dart ' . l:file
  elseif l:ext ==# 'swift'
    execute '!clear && time swift ' . l:file
  elseif l:ext ==# 'kt'
    execute '!clear && kotlinc ' . l:file . ' -include-runtime -d /tmp/kotlin_out.jar && time java -jar /tmp/kotlin_out.jar && rm /tmp/kotlin_out.jar'
  elseif l:ext ==# 'scala'
    execute '!clear && time scala ' . l:file
  elseif l:ext ==# 'r' || l:ext ==# 'R'
    execute '!clear && time Rscript ' . l:file
  else
    echo "❌ Unsupported file type: " . l:ext
  endif
endfunction

" Map F9 to run the current file
nnoremap <F9> :call RunFile()<CR>

" Map F9 to run the current file
nnoremap <F9> :call RunFile()<CR>


autocmd FileType java setlocal omnifunc=javacomplete#Complete

nnoremap <leader>n : NERDTreeToggle <CR>
nnoremap ff : NERDTreeFind <CR>

iabbr sout System.out.println("

let g:UltiSnipsExpandTrigger="<C-l>"
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0
let g:airline_theme='simple'

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


"-------------------------------------------------coc.nvim
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


runtime macros/matchit.vim

let g:user_emmet_settings = {
\  'variables': {'lang': 'ja'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

syntax on
set re=2

"let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>dr :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver


" " Initialize configuration dictionary
let g:fzf_vim = {}

" Set FZF to use the directory where Vim was started
let g:fzf_command_prefix = 'Fzf'  " Optional: use a prefix for commands
let g:fzf_vim.preview_window = ['down,90%', 'ctrl-/']
nnoremap <leader>f :FZF <CR>

command! -bang -nargs=* CustomFzfAg call fzf#vim#ag(<q-args>, '--ignore "*.po" --ignore "*.pot" --ignore "*.md" --ignore "*.jpg" --ignore "*.png" --ignore "*.rst"', fzf#vim#with_preview({'options': '--exact'}), <bang>0)
nnoremap <leader>g :CustomFzfAg<CR>
nnoremap <leader>rf :%!ruff format<CR>

" Open quickfix list
nnoremap <leader>co :copen<CR>

" Close quickfix list
nnoremap <leader>cc :cclose<CR>

" Navigate to next item in quickfix list
nnoremap <C-j> :cnext<CR>

" Navigate to previous item in quickfix list
nnoremap <C-k> :cprev<CR>

" Automatically open quickfix list after :vimgrep, :make, etc.
autocmd QuickFixCmdPost [^l]* copen
