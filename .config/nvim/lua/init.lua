local utils = require('utils')

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Do not source the default filetype.vim (use the plugin)
vim.g.did_load_filetypes = 1

-- mappings to copy to clipboard
utils.nnoremap("y", '"+y')
utils.nnoremap("Y", '"+y$')
utils.nnoremap("p", '"+p')
utils.nnoremap("P", '"+P')
utils.nnoremap("m", '"+d')
utils.nnoremap("M", '"+D')
utils.nnoremap("mm", '"+dd')

utils.vnoremap("y", '"+y')
utils.vnoremap("p", '"+p')
utils.vnoremap("m", '"+d')

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

require('plugins')
vim.cmd[[
  try
    colorscheme tokyonight
  catch
    colorscheme slate
  endtry
]]
