-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("gabe_" .. name, { clear = true })
end

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup("start_hyprlang_lsp"),
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})

-- Biome LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("biome_lsp_attach"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "biome" then
      return
    end

    vim.api.nvim_create_user_command("BiomeFixAll", function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.fixAll.biome" },
          diagnostics = {},
        },
        apply = true,
      })
    end, { desc = "Run Biome fixAll code action" })
  end,
})
