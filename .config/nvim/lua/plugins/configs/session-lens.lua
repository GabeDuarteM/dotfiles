require('session-lens').setup {
  path_display = { 'shorten' },
  previewer = false,
}

vim.keymap.set("n", "<leader>fs", ":SearchSession<CR>", { silent = true })
