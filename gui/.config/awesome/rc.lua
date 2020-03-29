local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local naughty = require("naughty")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

modkey       = "Mod4"
altkey       = "Mod1"
terminal     = "kitty -1"
editor       = os.getenv("EDITOR") or "vim"
browser      = "google-chrome-stable"

--------------------
-- Error handling
--------------------
-- Handle startup errors
if awesome.startup_errors then
  naughty.notify({ title = "An error occurred!", text = awesome.startup_errors, preset = naughty.conifg.presets.critical })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal(
    "debug::error",
    function (s)
      if in_error then return end
      in_error = true
      naughty.notify({ title = "An error occurred!", text = tostring(s), preset = naughty.conifg.presets.critical })
      in_error = false
    end
  )
end

--------------------
-- Autostart
--------------------

-- defer to xdg
awful.spawn.easy_async("dex -a")

--------------------
-- Layouts
--------------------
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.magnifier,
  awful.layout.suit.floating,
}

--------------------
-- Taglist
--------------------
awful.util.tagnames = { "1", "2", "3" }
awful.util.taglist_buttons = gears.table.join(
  awful.button({ }, 1, function (t) t:view_only() end),
  awful.button({ modkey }, 1, function (t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function (t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function (t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function (t) awful.tag.viewprev(t.screen) end)
)

--------------------
-- Tasklist
--------------------
awful.util.tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      --c:emit_signal("request::activate", "tasklist", {raise = true})

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
        instance = awful.menu.clients({ theme = { width = dpi(250) }})
      end
    end
  end),
  awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

--------------------
-- Theme
--------------------
beautiful.init(require("theme"))

--------------------
-- Menu
--------------------
awful.util.mymainmenu = awful.menu(
  {
    icon_size = beautiful.menu_height or dpi(16),
    items = {
      {
        "Power", {
          { "Suspend", "systemctl suspend-then-hibernate" },
          { "Hibernate", "systemctl hibernate" },
          { "Reboot", "systemctl reboot" },
          { "Poweroff", "systemctl poweroff" },
        },
      },
      {
        "Awesome", {
          { "Hotkeys", function () return false, hotkeys_popup.show_help end },
          { "Edit Config", string.format("%s %s %s", terminal, editor, awesome.conffile) },
          { "Restart", awesome.restart },
          { "Quit", function () awesome.quit() end },
        },
      },
      {
        "Config", {
          { "Sound", "pavucontrol" },
          { "Displays", "arandr" },
          { "Gtk3", "lxappearance" },
        },
      },
      {
        "Utilities", {
          { "Image Viewer", "gpicview" },
          { "Media Player", "smplayer" },
        },
      },
      { "Terminal", terminal },
      { "Web Browser", browser },
      { "Processes", string.format("%s htop", terminal) },
    },
  }
)

--------------------
-- Bindings
--------------------
require("bindings")

--------------------
-- Rules
--------------------
require("rules")

--------------------
-- Signals
--------------------
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal(
  "property::geometry",
  function (s)
    -- Wallpaper
    if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
    end
  end
)

-- Setup each screen
awful.screen.connect_for_each_screen(function (s) beautiful.at_screen_connect(s) end)

-- Refresh screen setup if the primary screen changes
screen.connect_signal("primary_changed", function (s) beautiful.at_screen_connect(s) end)

-- Signal function to execute when a new client appears.
client.connect_signal(
  "manage",
  function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
