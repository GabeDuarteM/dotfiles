local utils = require('utils')

require('session-lens').setup {
  path_display = { 'shorten' },
  previewer = false,
}

utils.nnoremap("<leader>fs", ":SearchSession<CR>", { silent = true })
