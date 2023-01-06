vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Do not source the default filetype.vim (use the plugin)
vim.g.did_load_filetypes = 1

-- mappings to copy to clipboard
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "Y", '"+y$')
vim.keymap.set("n", "p", '"+p')
vim.keymap.set("n", "P", '"+P')
vim.keymap.set("n", "m", '"+d')
vim.keymap.set("n", "M", '"+D')
vim.keymap.set("n", "mm", '"+dd')

vim.keymap.set("v", "y", '"+y')
vim.keymap.set("v", "p", '"+p')
vim.keymap.set("v", "m", '"+d')

require('plugins')
vim.cmd [[
  try
    colorscheme tokyonight
  catch
    colorscheme slate
  endtry
]]
