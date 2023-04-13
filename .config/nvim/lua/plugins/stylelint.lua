return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(
        opts.sources,
        nls.builtins.diagnostics.stylelint.with({
          dynamic_command = require("null-ls.helpers.command_resolver").from_yarn_pnp(),
        })
      )
      table.insert(
        opts.sources,
        nls.builtins.formatting.stylelint.with({
          dynamic_command = require("null-ls.helpers.command_resolver").from_yarn_pnp(),
        })
      )
    end,
  },
}
-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       stylelint_lsp = {
--         filetypes = { "css", "scss" },
--         settings = {
--           stylelintplus = {
--             autoFixOnformat = true,
--             autoFixOnSave = true,
--           },
--         },
--       },
--     },
--   },
-- }
