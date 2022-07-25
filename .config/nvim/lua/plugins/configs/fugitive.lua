-- autocmd BufReadPost */.git/index nmap <buffer> <TAB> =
print("fugitive.lua loaded")
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "fugitive:///*/.git/*",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<TAB>", "=", { noremap = false })
        -- vim.api.nvim_buf_set_keymap(0, "n", "<space>", "-", { nowait = true, noremap = false })
    end,
    group = vim.api.nvim_create_augroup("FugitiveStatus", { clear = true })
})
