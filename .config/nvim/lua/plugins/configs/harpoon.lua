vim.keymap.set("n", "<leader>hh", ':lua require("harpoon.ui").toggle_quick_menu()<cr>')
vim.keymap.set("n", "<leader>ha", ':lua require("harpoon.mark").add_file()<cr>')

for number = 1, 9, 1 do
    vim.keymap.set("n", "<leader>h" .. number, ':lua require("harpoon.ui").nav_file(' .. number .. ')<cr>')
end
