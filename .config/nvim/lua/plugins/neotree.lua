local function replace(str, what, with)
  what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
  with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
  return string.gsub(str, what, with)
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fE",
        function()
          -- Added the reveal = true
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root(), reveal = true })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fe",
        function()
          -- Added the reveal = true
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_hidden = false,
        },
      },
      window = {
        position = "float",
        mappings = {
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local absolute_path = node.path
            -- need the replace funtion to handle paths with '-', as this is a special character in lua's gsub
            local relative_path = replace(absolute_path, state.path, ""):sub(2)

            vim.fn.setreg('"', relative_path)
            vim.fn.setreg("1", relative_path)
            vim.fn.setreg("+", relative_path)
          end,
          ["o"] = "open",
          -- disable fuzzy search
          ["/"] = "noop",
        },
      },
    },
  },
}
