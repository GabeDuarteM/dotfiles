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

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

-- Makes ESC instant, preventing a really fast `ESC + j/k` to move the line up/down instead of escaping
vim.opt.ttimeoutlen = 0

local git_dir = vim.fn.glob(".git")
local superproject = vim.fn.systemlist("git rev-parse --show-superproject-working-tree")[1]

-- Set git dir and worktree for the dotfiles by default when not in a git repo
if git_dir == "" and superproject ~= nil then
  vim.env.GIT_DIR = os.getenv("DOTFILES_GIT_DIR")
  vim.env.GIT_WORK_TREE = os.getenv("HOME")
end
