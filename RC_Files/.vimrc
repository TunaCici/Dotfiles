syntax on

set number
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

