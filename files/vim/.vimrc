" disable the space functionality, so it doesn't interfer when it is the leader
nnoremap <SPACE> <Nop>

" Make space the leader
let mapleader=" "

filetype plugin on

" Set the python binaries to use homebrew
let g:python_host_prog  = '/home/linuxbrew/.linuxbrew/bin/python'
let g:python3_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3'

" Hides buffers instead of closing them
set hidden

" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" Add highlight to the current line and customize it
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable line numbers
set relativenumber number

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

" duplicate the current line
nmap <A-S-Up> yyP
nmap <A-S-Down> yyp

" Make copy and paste use the clipboard, instead of the register
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
vnoremap <leader>Y "+Y
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Move splitted windows
nnoremap <C-S-J> <C-W><C-S-J>
nnoremap <C-S-K> <C-W><C-S-K>
nnoremap <C-S-L> <C-W><C-S-L>
nnoremap <C-S-H> <C-W><C-S-H>

" Switch between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" move lines up and down
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Goes to the start of the line
noremap H ^
" Goes to the end of the line
noremap L g_ 
" Goes file lines above
noremap J 5j
" Goes file lines below
noremap K 5k

" Change the identation, but keep the selection
vmap < <gv
vmap > >gv

" Find and replace
map <leader>h :%s///gc<left><left><left><left>

" Clear highlighted search terms while preserving history
nmap <silent> <leader>/ :nohlsearch<CR>

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Source the other vim parts
source $DOTFILES_FOLDER/files/vim/plugins/index.vim

" UI
try
  colorscheme onedark
catch
  colorscheme slate
endtry
set termguicolors
set background=dark

