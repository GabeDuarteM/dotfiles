vim.api.nvim_set_keymap("n", "<C-n>", "NvimTreeToggle", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>r",':NvimTreeRefresh<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>n",':NvimTreeFindFileToggle<CR>', { noremap = true })

vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "",
    ignored = "◌"
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  }
}

require'nvim-tree'.setup { 
    update_cwd = true,
    disable_netrw = false,
    view = {
      width = 70,
      auto_resize = true,
    }
}

