vim.api.nvim_set_keymap("n", "<leader>hh", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ha", ':lua require("harpoon.mark").add_file()<cr>', { noremap = true })

for number = 1,9,1 do
    vim.api.nvim_set_keymap("n", "<leader>h" .. number, ':lua require("harpoon.ui").nav_file('..number..')<cr>', { noremap = true })
end
