-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- reset the clipboard to its default config
vim.opt.clipboard = ""

if os.getenv("WSL_DISTRO_NAME") ~= nil then
  -- Running in WSL environment, apply clipboard configuration
  -- :help clipboard-wsl
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }

  -- Use wslview to open files in the default windows browser while on WSL
  -- https://www.google.com
  vim.g.netrw_browsex_viewer = "wslview"
end
