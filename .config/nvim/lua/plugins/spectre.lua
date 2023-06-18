return {
  "nvim-pack/nvim-spectre",
  opts = {
    default = {
      find = {
        --pick one of item in find_engine
        cmd = "rg",
        options = { "ignore-case", "hidden" },
      },
    },
  },
}
