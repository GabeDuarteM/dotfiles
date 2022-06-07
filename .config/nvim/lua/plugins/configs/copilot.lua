-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- let g:copilot_no_tab_map = v:true
-- vim.keymap.set('i', '<C-j>', ':call copilot#Accept("<CR>")')
-- vim.g.copilot_no_tab_map = true

vim.cmd('imap <silent><script><expr> <C-j> copilot#Accept("")')
vim.cmd("let g:copilot_no_tab_map = v:true")
