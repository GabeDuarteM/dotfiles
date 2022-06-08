local utils = require('utils')

utils.nnoremap("<C-n>", "NvimTreeToggle")
utils.nnoremap("<leader>r", ':NvimTreeRefresh<CR>')
utils.nnoremap("<leader>n", ':NvimTreeFindFileToggle<CR>')

local function search_inside_node(node)
  -- amount of <left> needed to put the cursor before the path
  local leftAmount = string.rep('<left>', string.len(node.absolute_path) + 1)

  vim.api.nvim_input(':CtrlSF  ' .. node.absolute_path .. leftAmount)
end

require 'nvim-tree'.setup {
  update_cwd = true,
  disable_netrw = false,
  respect_buf_cwd = true,
  view = {
    width = 70,
    mappings = {
      list = {
        { key = "<space>f", action = "search_inside_node", action_cb = search_inside_node },
      }
    }
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
