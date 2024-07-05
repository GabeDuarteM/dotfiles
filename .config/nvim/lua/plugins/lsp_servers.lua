return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = false,
        exclude = {}, -- filetypes for which you don't want to enable inlay hints
      },
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {},
        tailwindcss = {},
        astro = {},
        gopls = {},
      },
    },
  },
}
