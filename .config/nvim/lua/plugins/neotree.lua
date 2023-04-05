return {
  {
    "nvim-neo-tree/neo-tree.nvim",
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
        },
      },
    },
  },
}
