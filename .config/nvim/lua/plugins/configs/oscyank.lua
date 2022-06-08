local clipboard = {}

local function refreshClipboard()
  vim.fn.jobstart(
    "ssh local pbpaste",
    {
      stdout_buffered = true,
      on_stdout = function(_, data) clipboard = data end
    }
  )
end

refreshClipboard()

local function copy(lines, regtype)
  vim.fn.OSCYankString(table.concat(lines, "\n"))
  clipboard = { lines, regtype }
end

local function paste()
  refreshClipboard()
  return clipboard -- doesn't necessarily paste the current clipboard content, but it refreshes, so next paste it will be fine
end

local isInSsh = not (vim.env.SSH_CLIENT == nil)

if isInSsh then
  vim.api.nvim_create_user_command('RefreshClipboard', refreshClipboard, {})

  vim.g.clipboard = {
    name = "osc52",
    copy = {
      ["+"] = copy,
      ["*"] = copy
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste
    }
  }
end
