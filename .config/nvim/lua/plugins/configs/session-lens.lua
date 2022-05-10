require('session-lens').setup {
  path_display = {'shorten'},
  previewer = false,
}

vim.api.nvim_set_keymap("n", "<leader>fs", ":SearchSession<CR>", { noremap = true, silent = true })
