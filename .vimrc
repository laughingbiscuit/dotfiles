set nocompatible
syntax enable
filetype plugin on
set path+=**
set wildignore+=**/node_modules/**
set wildmenu
set ts=2
set softtabstop=0
set shiftwidth=2
set relativenumber
set expandtab
set smarttab
set directory=$HOME/.vim/swapfiles//
set tags=tags;/

"need to add go back end of line and verticle highlight
set virtualedit+=all
set colorcolumn=80

let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_banner=0

set splitbelow
set splitright

" map jk to escape
inoremap jk <ESC>

"set formatters
map gg=G :Neoformat<CR>

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile Vagrantfile set filetype=ruby 

" disable Ex mode
map Q <Nop>

function! ExecLine()
  exec "!".getline(".")
endfunction

function! CopyLine()
  exec "!tmux send-keys -t1 '".getline(".")."' && tmux select-pane -t1"
endfunction
noremap hjkl :call CopyLine()<CR><CR>

noremap ; :
