local awful, dpi, gears, lain, naughty, wibox = awful, dpi, gears, lain, naughty, wibox

local font_sans = "Fira Sans 10"
local font_sans_bold = "Fira Sans Bold 10"
local font_mono = "Fira Code 10"

local theme                                           = {}
theme.default_dir                                     = awful.util.get_themes_dir() .. "default"
theme.dir                                             = os.getenv("HOME") .. "/.config/awesome"
theme.icon_dir                                        = theme.dir .. "/icons"
theme.wallpaper                                       = theme.dir .. "/wall.png"
theme.font                                            = font_mono
theme.taglist_font                                    = font_sans
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
theme.widget_bat                                      = theme.icon_dir .. "/widget/bat.png"
theme.widget_ac                                       = theme.icon_dir .. "/widget/ac.png"
theme.widget_clock                                    = theme.icon_dir .. "/widget/clock.png"
theme.widget_vol                                      = theme.icon_dir .. "/widget/spkr.png"
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
local separator = wibox.widget.textbox(" ")

-- Clock
local clock_icon = wibox.widget.imagebox(theme.widget_clock)
local clock = wibox.widget.textclock(lain.util.markup.fontfg(font_sans, "#7788af", "%A %d %B") .. lain.util.markup.fontfg(font_mono, "#de5e1e", " %H:%M"))
local myclock = wibox.layout.fixed.horizontal()
myclock:add(clock_icon)
myclock:add(clock)

-- CPU
local cpu_icon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
  timeout = 3,
  settings = function()
    widget:set_markup(lain.util.markup.fontfg(font_mono, "#e33a6e", cpu_now.usage .. "%"))
  end
}).widget

local mycpu = wibox.layout.fixed.horizontal()
mycpu:add(cpu_icon)
mycpu:add(cpu)

-- MEM
local mem_icon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
  timeout = 3,
  settings = function()
    widget:set_markup(lain.util.markup.fontfg(font_mono, "#e0da37", mem_now.used .. "M"))
  end
}).widget

local mymem = wibox.layout.fixed.horizontal()
mymem:add(mem_icon)
mymem:add(mem)

-- Pulse volume
local vol_icon = wibox.widget.imagebox(theme.widget_vol)
local vol = lain.widget.pulse({
    timeout = 7,
    settings = function()
        vlevel = lain.util.markup.fontfg(font_mono, "#7493d2", volume_now.left .. "%")
        if volume_now.muted == "yes" then
          -- strikethrough to show muted
          vlevel = lain.util.markup.strike(vlevel)
        end
        widget:set_markup(vlevel)
    end
})

local myvol = wibox.layout.fixed.horizontal()
myvol:add(vol_icon)
myvol:add(vol.widget)

local vol_notify = nil

function volume_toggle_mute()
  awful.spawn.easy_async(
      "pamixer --toggle-mute --get-mute",
      function (stdout, stderr, reason, exitcode)
        vol:update()
        if string.gsub(stdout, '%s+', '') == "true" then
          vol_notify = naughty.notify({
              title = "Volume",
              text = "Muted",
              replaces_id = vol_notify,
              destroy = function () vol_notify = nil end
            }).id
        else
          vol_notify = naughty.notify({
              title = "Volume",
              text = "Unmuted",
              replaces_id = vol_notify,
              destroy = function () vol_notify = nil end
            }).id
        end
      end
    )
end

function volume_adjust(perc)
  local cmd = nil
  if perc > 0 then
    cmd = string.format("pamixer --increase %d --get-volume", perc)
  else
    cmd = string.format("pamixer --decrease %d --get-volume", math.abs(perc))
  end

  awful.spawn.easy_async(
      cmd,
      function (stdout, stderr, reason, exitcode)
        vol:update()
        vol_notify = naughty.notify({
            title = "Volume",
            text = string.format("%d%%", stdout),
            replaces_id = vol_notify,
            destroy = function () vol_notify = nil end
          }).id
      end
    )
end

vol.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() awful.spawn("pavucontrol") end),
    awful.button({}, 3, volume_toggle_mute),
    awful.button({}, 4, function() volume_adjust("+1") end),
    awful.button({}, 5, function() volume_adjust("-1") end)
  ))

-- Battery
local bat_icon = wibox.widget.imagebox(nil)
local last_ac_status = nil

local function bat_refresh()
  widget:set_markup(lain.util.markup.fontfg(font_mono, theme.fg_normal, bat_now.perc .. "%"))
  -- set icon if ac_status changed
  if bat_now.ac_status ~= last_ac_status then
    if bat_now.ac_status == 1 then
      bat_icon.image = theme.widget_ac
    else
      bat_icon.image = theme.widget_bat
    end
    bat_icon:emit_signal("widget::redraw_needed")
    last_ac_status = bat_now.ac_status
  end
end

local bat = lain.widget.bat({ battery = "BAT0", ac = "AC", settings = bat_refresh }).widget

local mybat = wibox.layout.fixed.horizontal()
mybat:add(bat_icon)
mybat:add(bat)

local bat_tt = awful.tooltip({ font = font_sans })
bat_tt:add_to_object(mybat)
mybat:connect_signal("mouse::enter",
    function ()
      bat_tt.text = string.format("%s %s%%\n%s remaining", bat_now.status, bat_now.perc, bat_now.time)
    end
  )

--------------------
-- Wibox setup
--------------------
-- launcher
local launcher = awful.widget.button({ image = theme.awesome_icon_launcher })
launcher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

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

  -- create systray widget
  if s.systray == nil then
    systray = wibox.widget.systray(true)
    s.systray = wibox.container.margin(systray, dpi(0), dpi(0), dpi(5), dpi(5))
  end

  if s.index == screen.primary.index then
    -- Display notifications only on the primary screen
    naughty.config.defaults.screen = s.index
    -- Create the wibox
    s.wibar_top = awful.wibar({ position = "top", screen = s, height = dpi(28) })
    -- Add widgets to the wibox
    s.wibar_top:setup({
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
      },
      nil, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        s.systray,
        separator,
        myvol,
        separator,
        mybat,
        separator,
        mymem,
        separator,
        mycpu,
        separator,
        myclock,
        separator,
      },
    })
  elseif s.wibar_top ~= nil then
    s.wibar_top:remove()
    s.wibar_top = nil
  end

  if s.wibar_bottom == nil then
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
      },
    })
  end
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

  awful.titlebar.enable_tooltip = false

  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 2, function() c:kill() end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  -- FIXME font not being used
  awful.titlebar(c, { size = dpi(20), font = font_sans }) : setup({
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
      layout  = wibox.layout.fixed.horizontal,
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
