local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

-- Handle startup errors that resulted in config fallback
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Startup Error",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Runtime Error",
                         text = tostring(err) })
        in_error = false
    end)
end

-- Keys
modkey = "Mod4"

-- Default applications
terminal = "termite-tmux"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
display_control = "arandr"
sound_control = "pavucontrol"

-- Theme
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
gears.wallpaper.set('#018574')

-- Get the base process name of a command
local function get_cmd_basename(cmd)
   findme = cmd
   firstspace = cmd:find(" ")
   if firstspace then
      findme = cmd:sub(0, firstspace -1)
   end
   return findme
end

-- Run once
local function run_once(cmd)
   awful.spawn.with_shell("pgrep -u $USER -x " .. get_cmd_basename(cmd) .. " > /dev/null || (" .. cmd .. ")")
end

-- Toggle
local function run_toggle(cmd)
   awful.spawn.with_shell("kill $(pgrep -u $USER -x " .. get_cmd_basename(cmd) .. ") || (" .. cmd .. ")")
end

run_once("udiskie")
run_once("nm-applet")
run_once("volumeicon")
run_once("blueman-applet")
run_once("cbatticon")
run_once("dropbox")
run_once("light-locker --lock-on-suspend")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
      awful.layout.suit.tile,
      awful.layout.suit.spiral,
      awful.layout.suit.max,
      awful.layout.suit.floating,
   }

-- Menu
menubar.utils.terminal = terminal

launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
      menu = awful.menu({
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
                     { "Sound", sound_control },
                     { "Displays", display_control },
                     { "Gtk3", "lxappearance" }
                  },
               },
               {
                  "Awesome", {
                     { "Hotkeys", function () return false, hotkeys_popup.show_help end },
                     { "Restart", awesome.restart },
                     { "Quit", function () awesome.quit() end }
                  }
               },
               { "Terminal", terminal },
               { "Browser", "chromium" },
               { "Media Player", "smplayer" },
               { "Image Viewer", "gpicview" },
               { "Passwords", "keepass" }
            }
         })
   })

-- Wibar
local taglist_buttons = gears.table.join(
      awful.button({ }, 1, function (t) t:view_only() end),
      awful.button({ modkey }, 1,
         function (t)
            if client.focus then
               client.focus:toggle_tag(t)
            end
         end)
   )

local tasklist_buttons = gears.table.join(
      awful.button({ }, 1,
         function (c)
            if c == client.focus then
               c.minimized = true
            else
               c.minimized = false
               if not c:isvisible() and c.first_tag then
                  c.first_tag:view_only()
               end
               client.focus = c
               c:raise()
            end
         end)
   )


-- Create clock and calendar popup
textclock = wibox.widget.textclock("%F %H:%M")
calendar_popup = awful.widget.calendar_popup.month()
calendar_popup:attach(textclock)

-- Define tags
local tags = { "1", "2", "3" }

-- Setup each screen
awful.screen.connect_for_each_screen(function (s)
   -- Separator
   s.separator = wibox.widget.textbox(" ")

   -- Each screen has it's own tag table
   awful.tag(tags, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()

    -- Create a layoutbox per screen.
   s.layoutbox = awful.widget.layoutbox(s)
   s.layoutbox:buttons(gears.table.join(
      awful.button({ }, 1, function () awful.layout.inc(1) end),
      awful.button({ }, 3, function () awful.layout.inc(-1) end)
   ))

   -- Create a taglist widget
   s.taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

   -- Create a tasklist widget
   s.tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

   -- Create the wibox
   s.wibox = awful.wibar({ position = "top", screen = s })
   s.wibox:setup {
      layout = wibox.layout.align.horizontal,
      {
         -- Left widgets
         layout = wibox.layout.fixed.horizontal,
         launcher,
         s.separator,
         s.taglist,
         s.promptbox,
         s.separator
      },
      -- Middle widgets
      s.tasklist,
      {
         -- Right widgets
         layout = wibox.layout.fixed.horizontal,
         s.separator,
         wibox.widget.systray(),
         s.separator,
         textclock,
         s.separator,
         s.layoutbox
      },
   }
end)

-- Mouse bindings
local client_buttons = gears.table.join(
       awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
       awful.button({ modkey }, 1, awful.mouse.client.move),
       awful.button({ modkey }, 3, awful.mouse.client.resize)
    )

-- Key bindings
local global_keys = gears.table.join(
      -- launch programs
      awful.key({ modkey }, "r", function () awful.screen.focused().promptbox:run() end,
                {description = "run prompt", group = "awesome: launcher"}),
      awful.key({ modkey }, "Return", function () awful.spawn(terminal) end,
                { description = "open a terminal", group = "awesome: launcher" }),
      -- focus windows
      awful.key({ modkey }, "h", function () awful.client.focus.bydirection("left") end,
                { description = "Focus the window the the left", group = "awesome: focus" }),
      awful.key({ modkey }, "j", function () awful.client.focus.bydirection("down") end,
                { description = "Focus the window the the down", group = "awesome: focus" }),
      awful.key({ modkey }, "k", function () awful.client.focus.bydirection("up") end,
                { description = "Focus the window the the up", group = "awesome: focus" }),
      awful.key({ modkey }, "l", function () awful.client.focus.bydirection("right") end,
                { description = "Focus the window the the right", group = "awesome: focus" }),
      -- move windows
      awful.key({ modkey, "Shift" }, "h", function () awful.client.swap.bydirection("left") end,
                { description = "Swap with window to the left", group = "awesome: layout" }),
      awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.bydirection("down") end,
                { description = "Swap with window below", group = "awesome: layout" }),
      awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.bydirection("up") end,
                { description = "Swap with window above", group = "awesome: layout" }),
      awful.key({ modkey, "Shift" }, "l", function () awful.client.swap.bydirection("right") end,
                { description = "Swap with window to the right", group = "awesome: layout" }),
      awful.key({ modkey, "Shift" }, "o", awful.client.movetoscreen),
      -- brightness control
      awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("brightnessctl set 5%-") end,
                { description = "Reduce screen brightness by 5%", group = "awesome: misc" }),
      awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("brightnessctl set +5%") end,
                { description = "Increase screen brightness by 5%", group = "awesome: misc" }),
      -- lock screen
      awful.key({ modkey }, "Escape", function() awful.util.spawn("light-locker-command -l") end,
                { description = "Lock the screen", group = "awesome: misc" })
   )

-- Add tag controls for each tag
for i = 1, math.min(9, #tags) do
   global_keys = gears.table.join(global_keys,
      -- View tag
      awful.key({ modkey }, "#" .. i + 9,
         function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
               tag:view_only()
            end
         end,
         { description = "View tag '" .. tags[i] .. "'", group = "awesome: tags" }),
      -- Add client to tag
      awful.key({ modkey, "Control" }, "#" .. i + 9,
         function ()
            if client.focus then
               local tag = client.focus.screen.tags[i]
               if tag then
                  client.focus:toggle_tag(tag)
               end
            end
         end,
         { description = "Add tag '" .. tags[i] .. "' to focused client", group = "awesome: tags" }),
      -- Move client to tag
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
         function ()
            if client.focus then
               local tag = client.focus.screen.tags[i]
               if tag then
                  client.focus:move_to_tag(tag)
               end
            end
         end,
         { description = "Move focused client to tag '" .. tags[i] .. "'", group = "awesome: tags" })
      )
end

root.keys(global_keys)

local client_keys = gears.table.join(
      -- window control
      awful.key(
         { modkey }, "f",
         function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
         end,
         { description = "Toggle fullscreen", group = "awesome: client" }),
      awful.key(
         { modkey }, "c", function (c) c:kill() end,
         { description = "Close window", group = "awesome: client" }),
      awful.key(
         { modkey }, "space", awful.client.floating.toggle,
         { description = "Toggle floating", group = "awesome: client" }),
      awful.key(
         { modkey }, "m",
         function (c)
            c.maximized = not c.maximized
            c:raise()
         end,
         { description = "(un)Maximize", group = "awesome: client" }),
      awful.key(
         { modkey }, "n",
         function (c)
            c.minimized = true
         end,
         { description = "Minimize", group = "awesome: client" }),
      awful.key(
         { modkey }, "v",
         function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
         end,
         { description = "Vertically (un)maximize", group = "awesome: client" })
   )

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   {
      rule = { },
      properties = {
         border_width = beautiful.border_width,
         border_color = beautiful.border_normal,
         focus = awful.client.focus.filter,
         raise = true,
         keys = client_keys,
         buttons = client_buttons,
         screen = awful.screen.preferred,
         placement = awful.placement.no_overlap+awful.placement.no_offscreen
      }
   },

   -- Floating and centered clients.
   {
      rule_any = {
         instance = { sound_control, display_control, "blueman-manager", "lxappearance", "nm-connection-editor" },
         role = { "pop-up" }
      },
      properties = {
         floating = true,
         placement = awful.placement.centered
      },
   }
}

-- Prevent clients from being unreachable after screen count changes.
client.connect_signal("manage", function (c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function (c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function ()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function ()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
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
client.connect_signal("mouse::enter", function (c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function (c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function (c) c.border_color = beautiful.border_normal end)
