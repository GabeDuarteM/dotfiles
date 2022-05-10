local actions = require "telescope.actions"
local utils = require "utils"

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<leader>q"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
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
-- require('telescope').load_extension('fzf')
require'telescope'.load_extension('project')

utils.nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
utils.nnoremap("<leader>fg", ":Telescope grep_string", { noremap = true })
utils.nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })
utils.nnoremap("<leader>fv", "<cmd>lua require('telescope.builtin').file_browser()<cr>", { noremap = true })
utils.nnoremap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })
