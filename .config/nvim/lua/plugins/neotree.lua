return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          -- Added the reveal = true
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root(), reveal = true })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          -- Added the reveal = true
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    opts = {
      window = {
        position = "float",
        mappings = {
          ["Y"] = function(state)
            local node = state.tree:get_node()
            -- local content = node.path
            -- relative
            local content = node.path:gsub(state.path, ""):sub(2)
            vim.fn.setreg('"', content)
            vim.fn.setreg("1", content)
            vim.fn.setreg("+", content)
          end,
          ["o"] = "open",
          -- disable fuzzy search
          ["/"] = "noop",
        },
      },
    },
  },
}
