return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for ft, formatters in pairs(opts.formatters_by_ft) do
        if type(formatters) == "table" then
          opts.formatters_by_ft[ft] = vim.tbl_filter(function(formatter)
            return formatter ~= "markdownlint-cli2"
          end, formatters)
        end
      end
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft["markdown.mdx"] = {}
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.sources then
        return
      end
      opts.sources = vim.tbl_filter(function(source)
        if type(source) ~= "table" then
          return true
        end
        return source.name ~= "markdownlint" and source.name ~= "markdownlint-cli2"
      end, opts.sources)
    end,
  },
}
