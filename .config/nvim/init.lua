vim.cmd([[
  lua pcall(require, 'impatient')
  let g:did_load_filetypes = 1

  " Make space the leader
  let mapleader=" "

  let $BASH_ENV = "~/.aliases.sh"

  " filetype plugin on

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

  " ignore case when searching
  set ignorecase

  " if the search string has an upper case letter in it, the search will be case sensitive
  set smartcase

  " Automatically re-read file if a change was detected outside of vim
  set autoread

  " Enable line numbers
  set number

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

  function s:MkNonExDir(file, buf)
      if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
          let dir=fnamemodify(a:file, ':h')
          if !isdirectory(dir)
              call mkdir(dir, 'p')
          endif
      endif
  endfunction

  augroup vimrcEx
    autocmd!

    autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc set filetype=json
    " stops vim from automatically adding comments on new lines
    au FileType * set formatoptions-=c formatoptions-=r formatoptions-=o

    " notify if file changed outside of vim to avoid multiple versions
    autocmd FocusGained * checktime
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
  augroup END

  set termguicolors
  set background=dark

  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " folding options
  " syntax highlighting items specify folds
  set foldmethod=syntax 
  " defines 1 col at window left, to indicate folding
  set foldcolumn=1 
  " set to show all folds opened by default
  set foldlevelstart=99

  " Source local config if available
  if filereadable($HOME . '/.vimrc.local')
    source ~/.vimrc.local
  endif

  lua require('init')

  " Things for the undercurl to work on vim
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
]])

local filetypeAuGroup = vim.api.nvim_create_augroup("DefineCustomFileTypes", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "*\\.env*" },
  callback = function()
    print("Detecting .env file, switching filetype to sh")
    vim.bo.filetype = "sh"
  end,
  group = filetypeAuGroup,
})
