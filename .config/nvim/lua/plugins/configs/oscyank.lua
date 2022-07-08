local isInSsh = not (vim.env.SSH_CLIENT == nil) -- I share this config with my local machine, so I need this to ignore this provider if not on ssh

if isInSsh then
  local clipboard = {}

  local function refreshClipboard()
    vim.fn.jobstart(
    -- I have a reverse ssh tunnel to my local machine called "local", which allows me to get stuff from my macbook's pbpaste
      "ssh local pbpaste",
      {
        stdout_buffered = true,
        on_stdout = function(_, data) clipboard = data end
      }
    )
  end

  refreshClipboard() -- Initialize the clipboard when the file is loaded

  local function copy(lines, regtype)
    vim.fn.OSCYankString(table.concat(lines, "\n"))
    clipboard = { lines, regtype }
  end

  -- doesn't necessarily paste the current clipboard content (if, for example, I copy something outside vim)
  -- but it refreshes when called, so if you try again it will paste the current clipboard content
  -- I do this as a compromise to avoid delays when pasting
  local function paste()
    refreshClipboard()
    return clipboard
  end

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
