return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    -- inlay_hints = {
    --   enabled = false,
    --   exclude = {}, -- filetypes for which you don't want to enable inlay hints
    --   autoformat = false,
    -- },
    setup = {
      tailwindcss = function()
        Snacks.util.lsp.on(function(_, client)
          if client.name == "tailwindcss" then
            client.server_capabilities.workspace = client.server_capabilities.workspace or {}
            client.server_capabilities.workspace.didChangeWatchedFiles = nil
            client.capabilities.workspace = client.capabilities.workspace or {}
            client.capabilities.workspace.didChangeWatchedFiles = nil
          end
        end)
      end,
      eslint = function()
        Snacks.util.lsp.on(function(_, client)
          -- Disables autoformat for eslint and vtsls (leave it to conform to do it, which would probably use prettier)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
          if client.name == "vtsls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end)
      end,
    },
  },
}
