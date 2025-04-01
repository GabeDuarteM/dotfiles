local function hasPrettierDependency()
  local package_json_path = vim.fn.getcwd() .. "/package.json"
  local has_prettier = false

  local file = io.open(package_json_path, "r")

  if file then
    local package_json_content = file:read("*all")
    file:close()

    local package_data = vim.json.decode(package_json_content)
    -- print(vim.inspect(package_data))
    if package_data then
      if package_data.dependencies then
        -- if has text
        if package_data.dependencies["prettier"] then
          -- if package_data.dependencies["prettier"] == "3.3.2" then
          has_prettier = true
        end
      end
      if package_data.devDependencies then
        if package_data.devDependencies["prettier"] then
          -- if package_data.devDependencies["prettier"] == "3.3.2" then
          has_prettier = true
        end
      end
    end
  end

  return has_prettier
end

local supported = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}

    for _, ft in ipairs(supported) do
      opts.formatters_by_ft[ft] = { "prettierd" }
    end

    opts.formatters = opts.formatters or {}
    opts.formatters.prettierd = {
      condition = function()
        -- print("Checking if prettier should run")
        local has_prettier = hasPrettierDependency()
        -- print("has_prettier: " .. tostring(has_prettier))

        return has_prettier
      end,
    }
  end,
  -- opts = {
  --   formatters_by_ft = {
  --     ["javascript"] = getJsFormatters,
  --     ["javascriptreact"] = getJsFormatters,
  --     ["typescript"] = getJsFormatters,
  --     ["typescriptreact"] = getJsFormatters,
  --     ["vue"] = getJsFormatters,
  --     ["css"] = getJsFormatters,
  --     ["scss"] = getJsFormatters,
  --     ["less"] = getJsFormatters,
  --     ["html"] = getJsFormatters,
  --     ["json"] = getJsFormatters,
  --     ["jsonc"] = getJsFormatters,
  --     ["yaml"] = getJsFormatters,
  --     ["markdown"] = getJsFormatters,
  --     ["markdown.mdx"] = getJsFormatters,
  --     ["graphql"] = getJsFormatters,
  --     ["handlebars"] = getJsFormatters,
  --   },
  -- },
}
--
-- return {
--   "stevearc/conform.nvim",
--   opts = {
--     formatters_by_ft = {
--       ["javascript"] = { { "prettierd", "prettier" } },
--       ["javascriptreact"] = { { "prettierd", "prettier" } },
--       ["typescript"] = { { "prettierd", "prettier" } },
--       ["typescriptreact"] = { { "prettierd", "prettier" } },
--       ["vue"] = { { "prettierd", "prettier" } },
--       ["css"] = { { "prettierd", "prettier" } },
--       ["scss"] = { { "prettierd", "prettier" } },
--       ["less"] = { { "prettierd", "prettier" } },
--       ["html"] = { { "prettierd", "prettier" } },
--       ["json"] = { { "prettierd", "prettier" } },
--       ["jsonc"] = { { "prettierd", "prettier" } },
--       ["yaml"] = { { "prettierd", "prettier" } },
--       ["markdown"] = { { "prettierd", "prettier" } },
--       ["markdown.mdx"] = { { "prettierd", "prettier" } },
--       ["graphql"] = { { "prettierd", "prettier" } },
--       ["handlebars"] = { { "prettierd", "prettier" } },
--     },
--   },
-- }
