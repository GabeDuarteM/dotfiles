return {
  "goolord/alpha-nvim",
  opts = function(_, dashboard)
    -- Replace Persistence with persisted
    for _, button in ipairs(dashboard.section.buttons.val) do
      if button.opts.shortcut == "s" then
        button.opts.keymap[3] = ':lua require("persisted").load() <cr>'
        break -- Exit the loop once we've found and updated the shortcut
      end
    end
  end,
}
