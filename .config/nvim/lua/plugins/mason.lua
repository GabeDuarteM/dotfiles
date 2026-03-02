return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        "astro-language-server",
        "bash-language-server",
        "css-lsp",
        "css-variables-language-server",
        "cssmodules-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "biome",

        "hyprls",
        "json-lsp",
        "lua-language-server",
        "markdown-toc",
        "marksman",
        "prettierd",
        "shellcheck",
        "shfmt",
        "stylua",
        "yaml-language-server",
      })

      -- Remove markdownlint-cli2 from ensure_installed, which is automatically
      -- added by lazyvim's markdown config, and its annoying as hell.
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "markdownlint-cli2"
      end, opts.ensure_installed)
    end,
  },
  -- { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
}
