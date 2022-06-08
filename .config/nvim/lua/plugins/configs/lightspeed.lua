vim.api.nvim_set_keymap("n", "s", "<Plug>Lightspeed_omni_s", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", "<Plug>Lightspeed_omni_s<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", "<Plug>Lightspeed_omni_s<CR>", { silent = true })
vim.api.nvim_set_keymap("o", "<leader>j", "<Plug>Lightspeed_omni_s<CR>", { silent = true })
vim.api.nvim_set_keymap("o", "<leader>k", "<Plug>Lightspeed_omni_s<CR>", { silent = true })
vim.api.nvim_set_keymap("o", "z", "<Plug>Lightspeed_omni_s<CR>", { silent = true })

require 'lightspeed'.setup {
  ignore_case = true,
}
