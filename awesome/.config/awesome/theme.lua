local awful, dpi, gears, lain, wibox = awful, dpi, gears, lain, wibox

local theme                                           = {}
theme.default_dir                                     = awful.util.get_themes_dir() .. "default"
theme.dir                                             = os.getenv("HOME") .. "/.config/awesome"
theme.icon_dir                                        = theme.dir .. "/icons"
theme.wallpaper                                       = theme.dir .. "/wall.png"
theme.font                                            = "Monospace 9"
theme.taglist_font                                    = "Sans Regular 9"
theme.fg_normal                                       = "#FFFFFF"
theme.fg_focus                                        = theme.fg_normal
theme.bg_focus                                        = "#303030"
theme.bg_normal                                       = "#202020"
theme.fg_urgent                                       = "#CC9393"
theme.bg_urgent                                       = "#006B8E"
theme.border_width                                    = dpi(2)
theme.border_normal                                   = "#252525"
theme.border_focus                                    = "#0099CC"
theme.taglist_fg_focus                                = theme.border_focus
theme.tasklist_bg_normal                              = theme.bg_focus
theme.tasklist_font_focus                             = "Monospace Bold 9"
theme.tasklist_fg_minimize                            = theme.fg_focus
theme.tasklist_bg_minimize                            = theme.bg_normal
theme.menu_font                                       = "Sans Regular 9"
theme.menu_height                                     = dpi(20)
theme.menu_width                                      = dpi(160)
theme.menu_icon_size                                  = dpi(24)
theme.awesome_icon                                    = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                           = theme.icon_dir .. "/awesome_icon.png"
theme.widget_temp                                     = theme.icon_dir .. "/widget/temp.png"
theme.widget_uptime                                   = theme.icon_dir .. "/widget/ac.png"
theme.widget_cpu                                      = theme.icon_dir .. "/widget/cpu.png"
theme.widget_weather                                  = theme.icon_dir .. "/widget/dish.png"
theme.widget_fs                                       = theme.icon_dir .. "/widget/fs.png"
theme.widget_mem                                      = theme.icon_dir .. "/widget/mem.png"
theme.widget_note                                     = theme.icon_dir .. "/widget/note.png"
theme.widget_note_on                                  = theme.icon_dir .. "/widget/note_on.png"
theme.widget_netdown                                  = theme.icon_dir .. "/widget/net_down.png"
theme.widget_netup                                    = theme.icon_dir .. "/widget/net_up.png"
theme.widget_mail                                     = theme.icon_dir .. "/widget/mail.png"
theme.widget_batt                                     = theme.icon_dir .. "/widget/bat.png"
theme.widget_clock                                    = theme.icon_dir .. "/widget/clock.png"
theme.widget_vol                                      = theme.icon_dir .. "/widget/spkr.png"
theme.taglist_squares_sel                             = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                           = theme.icon_dir .. "/square_unsel.png"
theme.spr_small                                       = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                                  = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                                       = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right                                = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                                        = theme.icon_dir .. "/spr_left.png"
theme.bar                                             = theme.icon_dir .. "/bar.png"
theme.bottom_bar                                      = theme.icon_dir .. "/bottom_bar.png"
theme.layout_tile                                     = theme.icon_dir .. "/layout/tile.png"
theme.layout_tileleft                                 = theme.icon_dir .. "/layout/tileleft.png"
theme.layout_tilebottom                               = theme.icon_dir .. "/layout/tilebottom.png"
theme.layout_tiletop                                  = theme.icon_dir .. "/layout/tiletop.png"
theme.layout_fairv                                    = theme.icon_dir .. "/layout/fairv.png"
theme.layout_fairh                                    = theme.icon_dir .. "/layout/fairh.png"
theme.layout_spiral                                   = theme.icon_dir .. "/layout/spiral.png"
theme.layout_dwindle                                  = theme.icon_dir .. "/layout/dwindle.png"
theme.layout_max                                      = theme.icon_dir .. "/layout/max.png"
theme.layout_magnifier                                = theme.icon_dir .. "/layout/magnifier.png"
theme.layout_floating                                 = theme.icon_dir .. "/layout/floating.png"
theme.tasklist_plain_task_name                        = false
theme.tasklist_disable_icon                           = false
theme.useless_gap                                     = 0
-- close button
theme.titlebar_close_button_normal                    = theme.icon_dir .. "/titlebar/close.png"
theme.titlebar_close_button_normal_hover              = theme.titlebar_close_button_normal
theme.titlebar_close_button_normal_press              = theme.titlebar_close_button_normal
theme.titlebar_close_button_focus                     = theme.titlebar_close_button_normal
theme.titlebar_close_button_focus_hover               = theme.titlebar_close_button_normal
theme.titlebar_close_button_focus_press               = theme.titlebar_close_button_normal
-- maximized button
theme.titlebar_maximized_button_normal                = theme.icon_dir .. "/titlebar/maximized.png"
theme.titlebar_maximized_button_focus                 = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_normal_active         = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_normal_active_hover   = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_normal_active_press   = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_focus_active          = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_focus_active_hover    = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_focus_active_press    = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_normal_inactive       = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_normal_inactive_hover = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_normal_inactive_press = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_focus_inactive        = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_focus_inactive_hover  = theme.titlebar_maximized_button_normal
theme.titlebar_maximized_button_focus_inactive_press  = theme.titlebar_maximized_button_normal
-- minimize button
theme.titlebar_minimize_button_normal                 = theme.icon_dir .. "/titlebar/minimize.png"
theme.titlebar_minimize_button_normal_hover           = theme.titlebar_minimize_button_normal
theme.titlebar_minimize_button_normal_press           = theme.titlebar_minimize_button_normal
theme.titlebar_minimize_button_focus                  = theme.titlebar_minimize_button_normal
theme.titlebar_minimize_button_focus_hover            = theme.titlebar_minimize_button_normal_hover
theme.titlebar_minimize_button_focus_press            = theme.titlebar_minimize_button_normal

theme.systray_icon_spacing = dpi(5)

--------------------
-- Widgets
--------------------
local markup = lain.util.markup

-- Clock
local myclockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#de5e1e", "%H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
  attach_to = { mytextclock },
  notification_preset = {
    fg = theme.fg_normal,
    bg = theme.bg_normal,
    font = theme.font -- NOTE must be monospace
  }
})

-- CPU
local mycpuicon = wibox.widget.imagebox(theme.widget_cpu)
local mycpu = lain.widget.cpu({
  timeout = 3,
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
  end
})

-- MEM
local mymemicon = wibox.widget.imagebox(theme.widget_mem)
local mymem = lain.widget.mem({
  timeout = 3,
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
  end
})

-- Pulse volume
local myvolicon = wibox.widget.imagebox(theme.widget_vol)
local myvol = lain.widget.pulse({
    timeout = 7,
    settings = function()
        vlevel = volume_now.left .. "%"
        if volume_now.muted == "yes" then
            vlevel = vlevel .. " M"
        end
        widget:set_markup(lain.util.markup("#7493d2", vlevel))
    end
})

theme.volume = myvol

function volume_toggle_mute()
  os.execute(string.format("pactl set-sink-mute %d toggle", theme.volume.device))
  theme.volume.update()
end

function volume_adjust(perc)
  os.execute(string.format("pactl set-sink-volume %d %s%%", theme.volume.device, perc))
  theme.volume.update()
end

theme.volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() awful.spawn("pavucontrol") end),
    awful.button({}, 3, volume_toggle_mute),
    awful.button({}, 4, function() volume_adjust("+1") end),
    awful.button({}, 5, function() volume_adjust("-1") end)
))

-- Battery
local mybaticon = wibox.widget.imagebox(theme.widget_batt)
local mybat = lain.widget.bat({
  timeout = 31,
  battery = "BAT0",
  notify = "off",
  settings = function()
    widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, bat_now.perc .. "% "))
  end
})

local mybat_t = awful.tooltip({ })
mybat_t:add_to_object(mybat.widget)
mybat.widget:connect_signal("mouse::enter",
  function ()
    awful.spawn.easy_async("acpi",
      function (stdout, stderr, reason, exit_code)
        -- trim trailing spaces
        mybat_t.text = stdout:gsub("^%s*(.-)%s*$", "%1")
      end
    )
    return "loading..."
  end
)

--------------------
-- Wibox setup
--------------------
-- launcher
local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher })
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

function theme.at_screen_connect(s)
  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
  mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rectangle)
  s.mytag = wibox.container.margin(mytaglistcont, dpi(0), dpi(0), dpi(5), dpi(5))

  -- Create the layoutbox widget
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(awful.util.table.join(
                         awful.button({ }, 1, function () awful.layout.inc( 1) end),
                         awful.button({ }, 3, function () awful.layout.inc(-1) end),
                         awful.button({ }, 4, function () awful.layout.inc( 1) end),
                         awful.button({ }, 5, function () awful.layout.inc(-1) end)))

  -- Create a tasklist widget
  mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, { spacing = dpi(5) })
  s.mytasklist = wibox.container.margin(mytasklist, dpi(5), dpi(5), dpi(5), dpi(5))

  -- create systray widget
  mysystray = wibox.widget.systray(true)
  s.mysystray = wibox.container.margin(mysystray, dpi(0), dpi(0), dpi(5), dpi(5))

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(28) })
  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytag,
      spr_small,
      s.mylayoutbox,
    },
    nil, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      s.mysystray,
      myvolicon,
      myvol.widget,
      mybaticon,
      mybat,
      mymemicon,
      mymem,
      mycpuicon,
      mycpu,
      myclockicon,
      mytextclock,
    },
  }

  -- Create the bottom wibox
  s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, height = dpi(28) })
  -- Add widgets to the bottom wibox
  s.mybottomwibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      spr_bottom_right,
    },
  }
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- Custom
  if beautiful.titlebar_fun then
    beautiful.titlebar_fun(c)
    return
  end

  awful.titlebar.enable_tooltip = false

  -- Default buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 2, function() c:kill() end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c, { size = dpi(20), font = theme.font }) : setup({
    { -- Left
      layout = wibox.layout.fixed.horizontal,
      buttons = buttons,
      awful.titlebar.widget.iconwidget(c),
    },
    { -- Middle
      { -- Title
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  })
  -- Hide the titlebar if not floating
  local l = awful.layout.get(c.screen)
  if not c.floating then
    awful.titlebar.hide(c)
  end
end)

return theme
