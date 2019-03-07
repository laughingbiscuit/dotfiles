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

let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_banner=0

set splitbelow
set splitright

"set Formatters
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au FileType javascript setlocal equalprg=js-beautify

" map jk to escape
inoremap jk <ESC>

map gg=G :Neoformat<CR>

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufRead,BufNewFile Vagrantfile set filetype=ruby 

" disable Ex mode
map Q <Nop>

function! ExecLine()
  exec "!".getline(".")
endfunction
