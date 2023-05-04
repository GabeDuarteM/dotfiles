return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.1",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = { { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find git files" } },
}
