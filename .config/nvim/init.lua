pcall(require, 'impatient')

vim.g.did_load_filetypes = 1

-- Make space the leader key
vim.g.mapleader = ' '

-- -- Hides buffers instead of closing them
-- vim.o.hidden = true

-- -- Insert spaces when TAB is pressed.
-- vim.o.expandtab = true

-- -- Change number of spaces that a <Tab> counts for during editing ops
-- vim.o.softtabstop = 2

-- -- Indentation amount for < and > commands.
-- vim.o.shiftwidth = 2

-- Add highlight to the current line and customize it
vim.o.cursorline = true

-- ignore case when searching
vim.o.ignorecase = true

-- if the search string has an upper case letter in it, the search will be case sensitive
vim.o.smartcase = true

-- Enable line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Set backups
if vim.fn.has('persistent_undo') then
  vim.o.undofile = true
  vim.o.undolevels = 3000
  vim.o.undoreload = 10000
end

-- set where swap file and undo/backup files are saved
vim.o.backupdir = vim.fn.expand("~") .. "/.local/share/nvim/backup//" -- Don't put backups in current dir
vim.o.directory = vim.fn.expand("~") .. "/.local/share/nvim/swap//" -- Don't put swaps in current dir
vim.o.backup = true

-- Don't show modes, as the airline already does
vim.o.noshowmode = true

-- Always display the status line
vim.o.laststatus = 2

-- -- Both options below should make scrolling faster
-- vim.o.ttyfast = true
-- vim.o.lazyredraw = true

-- Show invisible characters
vim.o.list = true
vim.o.listchars = "tab:»·,trail:·,nbsp:·"

-- Open new split panes to right and bottom, which feels more natural
vim.o.splitbelow = true
vim.o.splitright = true

-- -- Always use vertical diffs
vim.o.diffopt = vim.o.diffopt .. ",vertical"

-- interactive find replace preview
vim.o.inccommand = "nosplit"

vim.o.termguicolors = true
vim.o.background = "dark"

vim.o.updatetime = 250

-- -- don't give |ins-completion-menu| messages.
-- vim.o.shortmess = vim.o.shortmess .. "c"

-- folding options
-- syntax highlighting items specify folds
vim.o.foldmethod = "syntax"
-- defines 1 col at window left, to indicate folding
vim.o.foldcolumn = '1'
-- set to show all folds opened by default
vim.o.foldlevelstart = 99

-- -- Source local config if available
-- if vim.fn.filereadable(vim.env.HOME .. "/.vimrc.local") then
--   vim.fn.source(vim.env.HOME .. "/.vimrc.local")
-- end

-- Things for the undercurl to work on vim
vim.o.t_Cs = "\\e[4:3m"
vim.o.t_Ce = "\\e[4:0m"

vim.o.mouse = "a"

-- from kickstart

-- Enable break indent
vim.o.breakindent = true

vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Remap for dealing with word wrap
-- If you have a long line that wraps, the below remaps will make it so that you can
-- use the j and k keys to move the cursor to the next line in the visual wrapped line
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local filetypeAuGroup = vim.api.nvim_create_augroup("DefineCustomFileTypes", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*\\.env*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
  group = filetypeAuGroup,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".babelrc", ".eslintrc", ".prettierrc" },
  callback = function()
    vim.bo.filetype = "json"
  end,
  group = filetypeAuGroup,
})

local vimrcExAuGroup = vim.api.nvim_create_augroup("VimrcEx", { clear = true })

-- stops vim from automatically adding comments on new lines
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("c", "")
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("r", "")
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("o", "")
  end,
  group = vimrcExAuGroup,
})

-- notify if file changed outside of vim to avoid multiple versions
-- vim.api.nvim_create_autocmd({ "FocusGained" }, {
--   callback = 'checktime',
--   group = vimrcExAuGroup,
-- })

-- local function MkNonExDir(file, buf)
--   if vim.api.nvim_buf_get_option(buf, "buftype") == "" and file:match("^%a+:/.*") then
--     local dir = vim.fn.fnamemodify(file, ":h")
--     if not vim.fn.isdirectory(dir) then
--       vim.fn.mkdir(dir, "p")
--     end
--   end
-- end

-- -- Create directories for new files if they don't already exist
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   callback = function()
--     MkNonExDir(vim.fn.expand("<afile>"), vim.fn.expand("<abuf>"))
--   end,
--   group = vimrcExAuGroup,
-- })

require('init')
