" disable the space functionality, so it doesn't interfere when it is the leader
nnoremap <SPACE> <Nop>

" Make space the leader
let mapleader=" "

filetype plugin on

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
highlight CursorLine guibg=#100E23

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
" set where swap file and undo/backup files are saved
set backupdir=~/.local/share/nvim/backup// " Don't put backups in current dir
set directory=~/.local/share/nvim/swap// " Don't put swaps in current dir
set backup

" Don't show modes, as the airline already does
set noshowmode

" Always display the status line
set laststatus=2

" Make vim stop automatically adding comments on enter press
set formatoptions-=r " For insert mode
set formatoptions-=o " For when hitting "o" in normal mode

" Both options below should make scrolling faster
set ttyfast
set lazyredraw

" Enable wildmenu
set wildmenu

" Show invisible characters
set list
set listchars=tab:»·,trail:·,nbsp:·

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" interactive find replace preview
set inccommand=nosplit

augroup vimrcEx
  autocmd!

  autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc set filetype=json

  " notify if file changed outside of vim to avoid multiple versions
  autocmd FocusGained * checktime
augroup END

" ### Remaps ###

" duplicate the current line
nmap <A-S-Up> yyP
nmap <A-S-Down> yyp

" Make copy and paste use the clipboard, instead of the register
vnoremap <leader>y  "+y
vnoremap <leader>Y  "+yg$
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap <leader>dd "+dd
vnoremap <leader>d "+d

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

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize -10<CR>
nnoremap <Right> :vertical resize +10<CR>

" Goes to the start of the line
noremap H ^
" Goes to the end of the line
noremap L g_
" Goes file lines above
noremap J 5j
" Goes file lines below
noremap K 5k

" Tab/shift-tab to indent/outdent in visual mode.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Find and replace
map <leader>h :%s///gc<left><left><left><left>

" Clear highlighted search terms while preserving history
nmap <silent> <leader>/ :nohlsearch<CR>

" prevent entering ex mode accidentally
nnoremap Q <Nop>

" Source (reload) vimrc.
nnoremap <leader>so :source $MYVIMRC<cr>

" print the syntax highlighting under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" Source local config if available
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

" Source the other vim parts
source $DOTFILES_FOLDER/files/vim/plugins/index.vim

" UI
try
  colorscheme palenight
catch
  colorscheme slate
endtry
set termguicolors
set background=dark

highlight Normal guibg=#1e1c31
highlight CursorLine guibg=#100E23

function! CodeReview(...)
    " Get the result of git show in a list
    let flist = system('git diff master --name-only -- . ":(exclude)package-lock.json" ":(exclude)yarn.lock"')
    let flist = split(flist, '\n')

    " Create the dictionaries used to populate the quickfix list
    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
endfunction

command! CR call CodeReview()

" Compile the spell file, so that when one is externally added (e.g. manually
" editing the file), the spells gets refreshed on vim
command! CompileSpell mkspell! ~/.config/nvim/spell/en.utf-8.add

