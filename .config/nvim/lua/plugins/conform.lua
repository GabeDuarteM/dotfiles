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
          has_prettier = true
        end
      end
      if package_data.devDependencies then
        if package_data.devDependencies["prettier"] then
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
}
