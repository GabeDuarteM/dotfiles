return {
  "nvim-pack/nvim-spectre",
  enabled = false,
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
