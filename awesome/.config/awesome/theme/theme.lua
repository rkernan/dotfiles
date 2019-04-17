local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi   = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local string, os = string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- inherit default theme
local theme = dofile(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- TODO more colors
theme.font                                      = "sans 9"
theme.taglist_font                              = theme.font

theme.icon_dir                                  = awful.util.get_themes_dir() .. "default"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/submenu.png"

theme.bg_normal                                 = xrdb.backround
theme.bg_focus                                  = xrdb.color8
theme.bg_urgent                                 = xrdb.color3
theme.bg_minimize                               = theme.bg_normal
theme.bg_systray                                = theme.bg_focus

theme.fg_normal                                 = xrdb.foreground
theme.fg_focus                                  = theme.bg_normal
theme.fg_urgent                                 = theme.bg_normal
theme.fg_minimize                               = theme.bg_normal

theme.border_width                              = dpi(2)
theme.useless_gap                               = dpi(3)
theme.border_normal                             = theme.bg_focus
theme.border_focus                              = xrdb.color10
theme.border_marked                             = xrdb.color11

theme.tooltip_fg                                = theme.fg_normal
theme.tooltip_bg                                = theme.bg_normal

theme.tasklist_bg_normal                        = theme.bg_normal

theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(160)
theme.menu_icon_size                            = dpi(24)
theme.wibox_height                              = dpi(24)

-- clock
local mytextclock = wibox.widget.textclock()

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
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    -- TODO
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set(awful.layout.layouts[1]) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { bg_focus = theme.bg_focus })
    mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rectangle)
    s.mytag = wibox.container.margin(mytaglistcont, dpi(2), dpi(2), dpi(2), dpi(2))

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, { bg_focus = theme.bg_focus, shape = gears.shape.rectangle, shape_border_width = 0, shape_border_color = theme.tasklist_bg_normal, align = "center" })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = theme.wibox_height })
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytag,
            s.mylayoutbox,
        },
        nil, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
        },
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, height = theme.wibox_height })
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
            mytextclock,
        },
    }
end

return theme
