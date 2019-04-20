local awful, beautiful = awful, beautiful

awful.rules.rules = {
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_color,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false,
      floating = false
    }
  },
  -- floating clients
  {
    rule_any = {
      name = { },
      class = { },
      role = { "AlarmWindow", "pop-up" },
      type = { "dialog" }
    },
    properties = { floating = true }
  }
}
