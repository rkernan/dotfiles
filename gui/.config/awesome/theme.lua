local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local font_sans = "Fira Sans 10"
local font_sans_bold = "Fira Sans Bold 10"

local theme                                           = {}
theme.default_dir                                     = awful.util.get_themes_dir() .. "default"
theme.dir                                             = os.getenv("HOME") .. "/.config/awesome"
theme.wallpaper                                       = theme.dir .. "/wall.png"
theme.font                                            = font_sans
theme.fg_normal                                       = "#ffffff"
theme.fg_focus                                        = theme.fg_normal
theme.bg_focus                                        = "#303030"
theme.bg_normal                                       = "#202020"
theme.fg_urgent                                       = "#cc9393"
theme.bg_urgent                                       = "#006b8e"
theme.border_width                                    = dpi(2)
theme.border_normal                                   = "#252525"
theme.border_focus                                    = "#0099cc"
theme.taglist_fg_focus                                = theme.border_focus
theme.tasklist_bg_normal                              = theme.bg_focus
theme.tasklist_font                                   = font_sans
theme.tasklist_font_focus                             = font_sans_bold
theme.tasklist_fg_minimize                            = theme.fg_focus
theme.tasklist_bg_minimize                            = theme.bg_normal
theme.menu_font                                       = font_sans
theme.menu_height                                     = dpi(20)
theme.menu_width                                      = dpi(160)
theme.menu_icon_size                                  = dpi(24)
theme.notification_font                               = font_sans
theme.notification_icon_size                          = dpi(64)
theme.icon_dir                                        = theme.dir .. "/icons"
theme.awesome_icon                                    = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                           = theme.icon_dir .. "/awesome_icon.png"
theme.taglist_squares_sel                             = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                           = theme.icon_dir .. "/square_unsel.png"
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
theme.useless_gap                                     = 1
-- close button
theme.titlebar_close_button_focus                     = theme.icon_dir .. "/titlebar/close_focus.svg"
theme.titlebar_close_button_focus_hover               = theme.icon_dir .. "/titlebar/close_focus_hover.svg"
theme.titlebar_close_button_focus_press               = theme.icon_dir .. "/titlebar/close_focus_press.svg"
theme.titlebar_close_button_normal                    = theme.icon_dir .. "/titlebar/close_normal.svg"
theme.titlebar_close_button_normal_hover              = theme.icon_dir .. "/titlebar/close_normal_hover.svg"
theme.titlebar_close_button_normal_press              = theme.icon_dir .. "/titlebar/close_normal_press.svg"
-- maximize button
theme.titlebar_maximized_button_focus                 = theme.icon_dir .. "/titlebar/max_focus.svg"
theme.titlebar_maximized_button_focus_active          = theme.icon_dir .. "/titlebar/max_focus.svg"
theme.titlebar_maximized_button_focus_active_hover    = theme.icon_dir .. "/titlebar/max_focus_hover.svg"
theme.titlebar_maximized_button_focus_active_press    = theme.icon_dir .. "/titlebar/max_focus_press.svg"
theme.titlebar_maximized_button_focus_inactive        = theme.icon_dir .. "/titlebar/max_focus.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = theme.icon_dir .. "/titlebar/max_focus_hover.svg"
theme.titlebar_maximized_button_focus_inactive_press  = theme.icon_dir .. "/titlebar/max_focus_press.svg"
theme.titlebar_maximized_button_normal                = theme.icon_dir .. "/titlebar/max_normal.svg"
theme.titlebar_maximized_button_normal_active         = theme.icon_dir .. "/titlebar/max_normal.svg"
theme.titlebar_maximized_button_normal_active_hover   = theme.icon_dir .. "/titlebar/max_normal_hover.svg"
theme.titlebar_maximized_button_normal_active_press   = theme.icon_dir .. "/titlebar/max_normal_press.svg"
theme.titlebar_maximized_button_normal_inactive       = theme.icon_dir .. "/titlebar/max_normal.svg"
theme.titlebar_maximized_button_normal_inactive_hover = theme.icon_dir .. "/titlebar/max_normal_hover.svg"
theme.titlebar_maximized_button_normal_inactive_press = theme.icon_dir .. "/titlebar/max_normal_press.svg"
-- minimize button
theme.titlebar_minimize_button_focus                  = theme.icon_dir .. "/titlebar/min_focus.svg"
theme.titlebar_minimize_button_focus_hover            = theme.icon_dir .. "/titlebar/min_focus_hover.svg"
theme.titlebar_minimize_button_focus_press            = theme.icon_dir .. "/titlebar/min_focus_press.svg"
theme.titlebar_minimize_button_normal                 = theme.icon_dir .. "/titlebar/min_normal.svg"
theme.titlebar_minimize_button_normal_hover           = theme.icon_dir .. "/titlebar/min_normal_hover.svg"
theme.titlebar_minimize_button_normal_press           = theme.icon_dir .. "/titlebar/min_normal_press.svg"

theme.systray_icon_spacing = dpi(5)

-- Display notifications at botton left
naughty.config.defaults.position = "bottom_right"

-- Separator
local sep = wibox.widget.textbox(" ")

-- Clock
local clock = wibox.widget.textclock(string.format(" <span font='%s'>%%F %%R</span>", font_sans))

-- Launcher
local launcher = awful.widget.button({ image = theme.awesome_icon_launcher })
launcher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

-- System Tray
local systray = wibox.container.margin(wibox.widget.systray(true), dpi(0), dpi(0), dpi(5), dpi(5))

function theme.at_screen_connect(s)
  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Create a taglist widget
  if s.taglist == nil then
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
    taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
    taglist_c = wibox.container.background(taglist, theme.bg_focus, gears.shape.rectangle)
    s.taglist = wibox.container.margin(taglist_c, dpi(0), dpi(0), dpi(5), dpi(5))
  end

  -- Create the layoutbox widget
  if s.layoutbox == nil then
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
  end

  -- Create a tasklist widget
  if s.tasklist == nil then
    tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, { spacing = dpi(5) })
    s.tasklist = wibox.container.margin(tasklist, dpi(5), dpi(5), dpi(5), dpi(5))
  end

  if s.index == screen.primary.index then
    -- Display notifications only on the primary screen
    naughty.config.defaults.screen = s.index
    -- Create a widget 
    s.systray = wibox.layout.fixed.horizontal()
    s.systray:add(systray)
    s.systray:add(sep)
    s.systray:add(clock)
    s.systray:add(sep)
  else
    s.systray = nil
  end

  if s.wibar_bottom ~= nil then
    s.wibar_bottom:remove()
  end

  -- Create the bottom wibox
  s.wibar_bottom = awful.wibar({ position = "bottom", ontop = true, screen = s, height = dpi(28) })
  -- Add widgets to the bottom wibox
  s.wibar_bottom:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      launcher,
      s.taglist,
      s.layoutbox,
    },
    s.tasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      s.systray,
    },
  })
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  title = awful.titlebar.widget.titlewidget(c)
  -- title:set_markup_silently(string.format("<span font='%s'>This is a test!</span>", theme.font_sans))

  -- FIXME font not being used
  awful.titlebar(c):setup({
    { -- Left
      layout = wibox.layout.fixed.horizontal,
      buttons = buttons,
      awful.titlebar.widget.iconwidget(c),
    },
    { -- Middle
      { -- Title
        widget = title,
      },
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal,
    },
    { -- Right
      layout = wibox.layout.fixed.horizontal(),
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.closebutton(c),
    },
    layout = wibox.layout.align.horizontal,
  })
end)

return theme
