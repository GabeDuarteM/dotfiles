-- hyprland language ft
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "astro",
      "bash",
      "css",
      "dockerfile",
      "gitcommit",
      "go",
      "graphql",
      "html",
      "hyprlang",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "php",
      "prisma",
      "python",
      "regex",
      "rust",
      "scss",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
  },
}
