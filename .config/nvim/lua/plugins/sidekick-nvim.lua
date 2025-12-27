return {
  "folke/sidekick.nvim",
  opts = {
    nes = {
      enabled = false,
    },
  },
  keys = {
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "codex", focus = true })
      end,
      desc = "Sidekick Toggle Codex",
    },
  },
}
