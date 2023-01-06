local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

vim.keymap.set("n", "<C-n>", "NvimTreeToggle")
vim.keymap.set("n", "<leader>r", ':NvimTreeRefresh<CR>')
vim.keymap.set("n", "<leader>n", ':NvimTreeFindFileToggle<CR>')

local function search_inside_node(node)
  -- amount of <left> needed to put the cursor before the path
  local leftAmount = string.rep('<left>', string.len(node.absolute_path) + 1)

  vim.api.nvim_input(':CtrlSF  ' .. node.absolute_path .. leftAmount)
end

local options = {
  respect_buf_cwd = true,

  filters = {
    dotfiles = false,
    exclude = { "custom" },
  },
  open_on_tab = false,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    width = 70,
    mappings = {
      list = {
        { key = "<space>f", action = "search_inside_node", action_cb = search_inside_node },
      }
    },
    side = "left",
  },
  git = {
    enable = false,
    ignore = true,
  },
  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = true,
    },
  },
  system_open = {
    cmd = "explorer.exe",
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },
    icons = {
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          open = "",
          empty = "",
          empty_open = "",
          default = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

nvimtree.setup(options)
