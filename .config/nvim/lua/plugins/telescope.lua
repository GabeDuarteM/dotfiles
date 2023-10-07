return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find git files" } },
    opts = {
      extensions = {
        frecency = {
          default_workspace = "CWD",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
    dependencies = { "kkharji/sqlite.lua" },
    keys = { { "<leader><leader>", "<cmd>Telescope frecency<cr>", desc = "Find files by frecency" } },
  },
}
