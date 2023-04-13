return {
  "tpope/vim-fugitive",
  keys = {
    { "gj", "<cmd>diffget //3<cr>", desc = "Git merge take right" },
    {
      "gf",
      "<cmd>diffget //2<cr>",
      desc = "Git merge take left",
    },
  },
}
