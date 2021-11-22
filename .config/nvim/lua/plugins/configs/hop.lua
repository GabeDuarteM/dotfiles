local utils = require('utils')

utils.nnoremap('s',':HopChar1<cr>')
utils.nnoremap('<leader>j',':HopLine<cr>')
utils.nnoremap('<leader>k',':HopLine<cr>')
utils.onoremap('z',':HopChar1<cr>')

require'hop'.setup()

