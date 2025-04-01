return {
  "nabekou29/js-i18n.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = function(opts)
    opts.primary_language = { "en", "dev", "de" }
    opts.virt_text = {
      max_length = 30,
    }
    return opts
  end,
}
