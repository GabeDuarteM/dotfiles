require("cheatsheet").setup({
    -- Whether to show bundled cheatsheets

    -- For generic cheatsheets like default, unicode, nerd-fonts, etc
    -- bundled_cheatsheets = true,
    bundled_cheatsheets = {
        enabled = { "default" },
        -- disabled = {},
    },

    -- For plugin specific cheatsheets
    -- bundled_plugin_cheatsheets = true,
    bundled_plugin_cheatsheets = {
        enabled = { "telescope.nvim", "vim-sandwich" },
        -- disabled = {},
    },

    -- For bundled plugin cheatsheets, do not show a sheet if you
    -- don't have the plugin installed (searches runtimepath for
    -- same directory name)
    include_only_installed_plugins = true,
})

vim.api.nvim_set_keymap("n", "<leader>?", ":Cheatsheet<CR>", { noremap = true, silent = true })
