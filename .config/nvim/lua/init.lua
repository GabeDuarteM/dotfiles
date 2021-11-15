vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Do not source the default filetype.vim (use the plugin)
vim.g.did_load_filetypes = 1


-- mappings to copy to clipboard
vim.api.nvim_set_keymap("n", "cy", '"+y', { noremap = true })
vim.api.nvim_set_keymap("n", "cY", '"+Y', {})
vim.api.nvim_set_keymap("n", "cyy", '"+yy', { noremap = true })
vim.api.nvim_set_keymap("n", "cp", '"+p', { noremap = true })
vim.api.nvim_set_keymap("n", "cP", '"+P', { noremap = true })
vim.api.nvim_set_keymap("n", "cd", '"+d', { noremap = true })
vim.api.nvim_set_keymap("n", "cdd", '"+dd', { noremap = true })

vim.api.nvim_set_keymap("v", "cy", '"+y', { noremap = true })
vim.api.nvim_set_keymap("v", "cp", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "cP", '"+P', { noremap = true })
vim.api.nvim_set_keymap("v", "cd", '"+d', { noremap = true })

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

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
