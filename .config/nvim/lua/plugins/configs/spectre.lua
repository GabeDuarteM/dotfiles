require('spectre').setup({
  find_engine = {
    -- rg is map with finder_cmd
    ['rg'] = {
      options = {
        ['no-ignore'] = {
          value= "--no-ignore",
          icon="[NI]",
          desc="No ignore (consider gitignored files on the search)"
        },
      }
    },
  },
})

vim.cmd[[command! Spectre lua require('spectre').open()]]
