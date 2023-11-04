return {
  "nvimdev/dashboard-nvim",
  opts = function(_, dashboard)
    -- Replace Persistence with persisted
    for _, button in ipairs(dashboard.config.center) do
      if button.key == "s" then
        button.action = 'lua require("persisted").load()'
        break -- Exit the loop once we've found and updated the shortcut
      end
    end
  end,
}
