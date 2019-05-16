" disable the space functionality, so it doesn't interfer when it is the leader
nnoremap <SPACE> <Nop>

" Make space the leader
let mapleader=" "

filetype plugin on

" Set the python binaries to use homebrew
let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

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

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc set filetype=json

  " Enable spellchecking some filetypes
  autocmd FileType markdown,gitcommit setlocal spell

  " notify if file changed outside of vim to avoid multiple versions
  autocmd FocusGained * checktime
augroup END

" ### Remaps ###

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

" Tab/shift-tab to indent/outdent in visual mode.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Change the identation, but keep the selection
vmap < <gv
vmap > >gv

" Find and replace
map <leader>h :%s///gc<left><left><left><left>

" Clear highlighted search terms while preserving history
nmap <silent> <leader>/ :nohlsearch<CR>

" prevent entering ex mode accidentally
nnoremap Q <Nop>

" Source (reload) vimrc.
nnoremap <leader>so :source $MYVIMRC<cr>

" command typo mapping
cnoremap WQ wq
cnoremap Wq wq
cnoremap Q! q!

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Source local config if available
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

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

" Terminal config
let g:term_buf = [0, 0, 0]
let g:term_win = [0, 0, 0]

function! g:TermToggle(height)
    let i = 0

    while i < 3
        if win_gotoid(g:term_win[i])
            hide
        else
            if i == 0
              botright new
            else
              vnew
            endif

            exec "resize " . a:height

            try
                exec "buffer " . g:term_buf[i]
            catch
                call termopen($SHELL, {"detach": 0})
                let g:term_buf[i] = bufnr("")
                set nonumber
                set norelativenumber
                set signcolumn=no
            endtry

            startinsert!

            let g:term_win[i] = win_getid()
        endif

        let i += 1
    endwhile

    call win_gotoid(g:term_win[0])
endfunction

let term_height = 15

" Toggle terminal on/off (neovim)
nnoremap <C-t> :call g:TermToggle(term_height)<CR>
inoremap <C-t> <Esc>:call g:TermToggle(term_height)<CR>
tnoremap <C-t> <C-\><C-n>:call g:TermToggle(term_height)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>0

