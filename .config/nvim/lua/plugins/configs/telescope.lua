local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require "telescope.actions"
local utils = require "utils"

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

    mappings = {
      i = { ["<leader>q"] = actions.send_selected_to_qflist + actions.open_qflist },
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
    }
  },
  pickers = {
    buffers = {
      -- previewer = false, -- hack for https://github.com/nvim-telescope/telescope.nvim/issues/1300 until https://github.com/nvim-telescope/telescope.nvim/pull/1400 is merged
      ignore_current_buffer = true,
      sort_mru = true,
      sort_lastused = true,
    },
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require 'telescope'.load_extension('project')

utils.nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
utils.nnoremap("<leader>fg", ":Telescope grep_string", { noremap = true })
utils.nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })
utils.nnoremap("<leader>fv", "<cmd>lua require('telescope.builtin').file_browser()<cr>", { noremap = true })
utils.nnoremap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })

telescope.setup(options)
