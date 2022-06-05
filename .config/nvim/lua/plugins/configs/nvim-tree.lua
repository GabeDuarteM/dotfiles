local utils = require('utils')

utils.nnoremap("<C-n>", "NvimTreeToggle")
utils.nnoremap("<leader>r",':NvimTreeRefresh<CR>')
utils.nnoremap("<leader>n",':NvimTreeFindFileToggle<CR>')

require'nvim-tree'.setup { 
    update_cwd = true,
    disable_netrw = false,
    respect_buf_cwd = true,
    view = {
      width = 70,
    },
    actions = {
      open_file = {
        quit_on_open = true,
        resize_window = true
      }
    },
    renderer = {
      icons = {
        glyphs = {
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
    }
  }
}
