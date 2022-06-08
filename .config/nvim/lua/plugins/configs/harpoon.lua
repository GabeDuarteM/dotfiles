local utils = require('utils')

utils.nnoremap("<leader>hh", ':lua require("harpoon.ui").toggle_quick_menu()<cr>')
utils.nnoremap("<leader>ha", ':lua require("harpoon.mark").add_file()<cr>')

for number = 1, 9, 1 do
    utils.nnoremap("<leader>h" .. number, ':lua require("harpoon.ui").nav_file(' .. number .. ')<cr>')
end
