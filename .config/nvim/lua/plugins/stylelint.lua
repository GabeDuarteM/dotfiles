return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      stylelint_lsp = {
        filetypes = { "css", "scss" },
        settings = {
          stylelintplus = {
            autoFixOnformat = true,
            autoFixOnSave = true,
          },
        },
      },
    },
  },
}
