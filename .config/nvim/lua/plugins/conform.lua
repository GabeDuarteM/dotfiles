local function getJsFormatters()
  local package_json_path = vim.fn.getcwd() .. "/package.json"
  local has_prettier = false

  print(vim.inspect(package_json_path))

  local file = io.open(package_json_path, "r")

  if file then
    local package_json_content = file:read("*all")
    file:close()

    local package_data = vim.json.decode(package_json_content)
    if package_data then
      if package_data.dependencies then
        if package_data.dependencies["prettier"] then
          has_prettier = true
        end
      elseif package_data.devDependencies then
        if package_data.devDependencies["prettier"] then
          has_prettier = true
        end
      end
    end
  end

  local formatters = {}

  -- if has_prettier then
  table.insert(formatters, "prettierd")
  table.insert(formatters, "prettier")
  -- end

  return formatters
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["javascript"] = getJsFormatters,
      ["javascriptreact"] = getJsFormatters,
      ["typescript"] = getJsFormatters,
      ["typescriptreact"] = getJsFormatters,
      ["vue"] = getJsFormatters,
      ["css"] = getJsFormatters,
      ["scss"] = getJsFormatters,
      ["less"] = getJsFormatters,
      ["html"] = getJsFormatters,
      ["json"] = getJsFormatters,
      ["jsonc"] = getJsFormatters,
      ["yaml"] = getJsFormatters,
      ["markdown"] = getJsFormatters,
      ["markdown.mdx"] = getJsFormatters,
      ["graphql"] = getJsFormatters,
      ["handlebars"] = getJsFormatters,
    },
  },
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
