vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Do not source the default filetype.vim (use the plugin)
vim.g.did_load_filetypes = 1


-- mappings to copy to clipboard
vim.api.nvim_set_keymap("n", "y", '"+y', { noremap = true })
vim.api.nvim_set_keymap("n", "p", '"+p', { noremap = true })
vim.api.nvim_set_keymap("n", "P", '"+P', { noremap = true })
vim.api.nvim_set_keymap("n", "m", '"+d', { noremap = true })
vim.api.nvim_set_keymap("n", "M", '"+D', { noremap = true })
vim.api.nvim_set_keymap("n", "mm", '"+dd', { noremap = true })

vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true })
vim.api.nvim_set_keymap("v", "p", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "m", '"+d', { noremap = true })

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', {})

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
