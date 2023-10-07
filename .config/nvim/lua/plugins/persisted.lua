return {
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
      use_git_branch = true,
      should_autosave = function()
        -- do not autosave if the alpha dashboard is the current filetype
        if vim.bo.filetype == "alpha" then
          return false
        elseif vim.bo.filetype == "spectre_panel" then
          return false
        end
        return true
      end,
      on_autoload_no_session = function()
        vim.notify("No existing session to load.")
      end,
    },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persisted").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persisted").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persisted").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
