return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
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
