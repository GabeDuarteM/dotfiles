local utils = require('utils')

utils.nnoremap("s", "<Plug>Lightspeed_omni_s", { silent = true })

require'lightspeed'.setup {
  ignore_case = true,
}
