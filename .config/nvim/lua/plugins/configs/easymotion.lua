vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s)", { silent = true })
vim.api.nvim_set_keymap("o", "z", "<Plug>(easymotion-s)", { silent = true })
vim.api.nvim_set_keymap("", "<leader>j", "<Plug>(easymotion-j)", { silent = true })
vim.api.nvim_set_keymap("", "<leader>k", "<Plug>(easymotion-k)", { silent = true })
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1
