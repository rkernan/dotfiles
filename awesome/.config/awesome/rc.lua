--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
-- local lain          = require("lain") -- FIXME
-- local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd)
      awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
end

-- TODO replace with widgets
run_once("nm-applet")
run_once("volumeicon")
run_once("blueman-applet")
run_once("cbatticon")

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

-- local themes = {
--     "blackburn",       -- 1
--     "copland",         -- 2
--     "dremora",         -- 3
--     "holo",            -- 4
--     "multicolor",      -- 5
--     "powerarrow",      -- 6
--     "powerarrow-dark", -- 7
--     "rainbow",         -- 8
--     "steamburn",       -- 9
--     "vertex",          -- 10
-- }

-- local chosen_theme = themes[4]
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "termite"
local editor       = os.getenv("EDITOR") or "vim" -- FIXME
local browser      = "chromium"
local scrlocker    = "light-locker-command -l" -- FIXME

awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3" }
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.spiral,
    awful.layout.suit.max,
    awful.layout.suit.floating,

    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 2, function (c) c:kill() end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

-- FIXME
-- lain.layout.termfair.nmaster           = 3
-- lain.layout.termfair.ncol              = 1
-- lain.layout.termfair.center.nmaster    = 3
-- lain.layout.termfair.center.ncol       = 1
-- lain.layout.cascade.tile.offset_x      = dpi(2)
-- lain.layout.cascade.tile.offset_y      = dpi(32)
-- lain.layout.cascade.tile.extra_padding = dpi(5)
-- lain.layout.cascade.tile.nmaster       = 5
-- lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME")))
-- }}}

-- {{{ Menu
awful.util.mymainmenu = awful.menu(
  {
    icon_size = beautiful.menu_height or dpi(16),
    items = {
      {
        "Power", {
          { "Suspend", "systemctl suspend" },
          { "Hibernate", "systemctl hibernate" },
          { "Reboot", "systemctl reboot" },
          { "Poweroff", "systemctl poweroff" }
        },
      },
      {
        "Config", {
          { "Sound", "pavucontrol" },
          { "Displays", "arandr" },
          { "Gtk3", "lxappearance" }
        },
      },
      {
        "Awesome", {
          { "Hotkeys", function () return false, hotkeys_popup.show_help end },
          { "Edit Config", string.format("%s -e '%s %s'", terminal, editor, awesome.conffile) },
          { "Restart", awesome.restart },
          { "Quit", function () awesome.quit() end }
        }
      },
      { "Terminal", terminal },
      { "Web Browser", browser },
      { "Media Player", "smplayer" },
      { "Image Viewer", "gpicview" },
      { "Passwords", "keepass" }
    }
  }
)

-- local myawesomemenu = {
--     { "hotkeys", function() return false, hotkeys_popup.show_help end },
--     { "manual", terminal .. " -e man awesome" },
--     { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
--     { "restart", awesome.restart },
--     { "quit", function() awesome.quit() end }
-- }
-- awful.util.mymainmenu = freedesktop.menu.build({
--     icon_size = beautiful.menu_height or dpi(16),
--     before = {
--         { "Awesome", myawesomemenu, beautiful.awesome_icon },
--         -- other triads can be put here
--     },
--     after = {
--         { "Open terminal", terminal },
--         -- other triads can be put here
--     }
-- })
-- hide menu when mouse leaves it
-- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

-- menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = my_table.join(
    -- launch programs
    -- TODO clipmenu
    awful.key({ modkey }, "r", function () awful.spawn("rofi -show run -modi run,window -sidebar-mode") end,
              { description = "open rofi", group = "awesome: launcher" }),
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end,
              { description = "open terminal", group = "awesome: launcher" }),
    -- reload config
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              { description = "restart awesome", group = "awesome: misc" }),
    -- volume control
    awful.key({ }, "XF86AudioMute", function () awful.spawn("pactl -- set-sink-mute 0 toggle") end,
              { description = "mute volume", group = "awesome: misc" }),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("pactl -- set-sink-volume 0 -5%") end,
              { description = "lower volume", group = "awesome: misc" }),
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn("pactl -- set-sink-volume 0 +5%") end,
              { description = "raise volume", group = "awesome: misc" }),
    -- brightness control
    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn("brightnessctl set 5%-") end,
              { description = "reduce screen brightness", group = "awesome: misc" }),
    awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn("brightnessctl set +5%") end,
              { description = "increase screen brightness", group = "awesome: misc" }),
    -- hotkey help
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
              {description = "show help", group="awesome: misc"}),
    -- lock screen
    awful.key({ modkey }, "l", function () os.execute(scrlocker) end,
              { description = "lock screen", group = "awesome: misc" }),
    -- client focus
    awful.key({ modkey }, "h", function () awful.client.focus.bydirection("left") end,
              { description = "focus left", group = "awesome: focus" }),
    awful.key({ modkey }, "j", function () awful.client.focus.bydirection("down") end,
              { description = "focus down", group = "awesome: focus" }),
    awful.key({ modkey }, "k", function () awful.client.focus.bydirection("up") end,
              { description = "focus up", group = "awesome: focus" }),
    awful.key({ modkey }, "l", function () awful.client.focus.bydirection("right") end,
              { description = "focus right", group = "awesome: focus" }),
    -- client position
    awful.key({ modkey, "Shift" }, "h", function () awful.client.swap.bydirection("left") end,
              { description = "swap left", group = "awesome: client" }),
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.bydirection("down") end,
              { description = "swap down", group = "awesome: client" }),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.bydirection("up") end,
              { description = "swap up", group = "awesome: client" }),
    awful.key({ modkey, "Shift" }, "l", function () awful.client.swap.bydirection("right") end,
              { description = "swap right", group = "awesome: client" }),
    -- tag browsing
    awful.key({ modkey }, "n", awful.tag.viewnext,
              { description = "next tag", group = "awesome: tag" }),
    awful.key({ modkey }, "p", awful.tag.viewprev,
              { description = "previous tag", group = "awesome: tag" })
    -- FIXME
    -- awful.key({ altkey }, "n", function () lain.util.tag_view_nonempty(1) end,
    --           { description = "next (nonempty) tag", group = "awesome: tag" }),
    -- awful.key({ altkey }, "p", function () lain.util.tag_view_nonempty(-1) end,
    --           { description = "previous (nonempty) tag", group = "awesome: tag" })
    -- Dynamic tagging
    -- TODO enable dynamic tagging?
    -- awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
    --           {description = "add new tag", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
    --           {description = "rename tag", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
    --           {description = "move tag to the left", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
    --           {description = "move tag to the right", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
    --           {description = "delete tag", group = "tag"}),
    -- FIXME what does this do?
    -- -- Copy primary to clipboard (terminals to gtk)
    -- awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
    --           {description = "copy terminal to gtk", group = "hotkeys"}),
    -- -- Copy clipboard to primary (gtk to terminals)
    -- awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
    --           {description = "copy gtk to terminal", group = "hotkeys"}),
)

clientkeys = my_table.join(
    -- window control
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "awesome: client" }),
    awful.key({ modkey }, "c", function (c) c:kill() end,
              { description = "close window", group = "awesome: client" }),
    awful.key({ modkey }, "space", awful.client.floating.toggle,
              { description = "toggle floating", group = "awesome: client" }),
    awful.key({ modkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "toggle maximized", group = "awesome: client" }),
    awful.key({ modkey }, "n",
        function (c)
            -- the client currently has input focus so it cannot be minimized
            c.minimized = true
        end,
              { description = "minimize", group = "awesome: client" }),
    awful.key({ modkey }, "v",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { description = "toggle vertical maximized", group = "awesome: client" }),
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end,
              { description = "toggle keep on top", group = "awesome: client" })
    -- FIXME
    -- awful.key({ altkey, "Shift"   }, "m", lain.util.magnify_client,
    --           { description = "magnify client", group = "awesome: client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "awesome: tag"}
        descr_toggle = {description = "toggle tag #", group = "awesome: tag"}
        descr_move = {description = "move focused client to tag #", group = "awesome: tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "awesome: tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    -- { rule_any = { type = { "dialog", "normal" } },
    --   properties = { titlebars_enabled = true } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
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

    awful.titlebar(c, {size = dpi(16)}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = true})
end)

-- No borders if only 1 non floating or maximised client visible
function border_adjust(c)
    if c.maximized or c.floating and #c.screen.clients == 1 then
        c.border_width = 0
    elseif #c.screen.clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end

client.connect_signal("property::maximized", border_adjust)
client.connect_signal("focus", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- possible workaround for tag preservation when switching back to default screen:
-- https://github.com/lcpz/awesome-copycats/issues/251
-- }}}
