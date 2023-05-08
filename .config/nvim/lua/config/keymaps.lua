-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- mappings to copy to clipboard
vim.keymap.set("n", "y", '"+y', { desc = "Yank to the + register" })
vim.keymap.set("n", "Y", '"+y$', { desc = "Yank until end of line to the + register" })
vim.keymap.set("n", "p", '"+p', { desc = "Paste from the + register" })
vim.keymap.set("n", "P", '"+P', { desc = "Paste above from the + register" })
vim.keymap.set("n", "m", '"+d', { desc = "Cut to the + register" })
vim.keymap.set("n", "M", '"+D', { desc = "Cut until the end of line to the + register" })
vim.keymap.set("n", "mm", '"+dd', { desc = "Cut whole line to the + register" })

vim.keymap.set("v", "y", '"+y', { desc = "Yank selection to the + register" })
vim.keymap.set("v", "p", '"+p', { desc = "Paste selection from the + register" })
vim.keymap.set("v", "m", '"+d', { desc = "Cut selection from the + register" })

-- " Find and replace
vim.keymap.set("n", "<leader>h", ":%s///gc<left><left><left><left>", { desc = "Find and replace" })
vim.keymap.set("v", "<leader>h", ":s///gc<left><left><left><left>", { desc = "Find and replace" })

-- " Move lines up and down while fixing indentation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- join lines keeping cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- seriously, why is Q still a thing?
-- vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")

vim.keymap.set("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-\\>", ":<C-U>TmuxNavigatePrevious<cr>", { noremap = true, silent = true })
