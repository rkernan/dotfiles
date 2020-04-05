local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local naughty = require("naughty")

--------------------
-- Global keys
--------------------
function client_toggle_maximized(c)
  c.maximized = not c.maximized
  c:raise()
end

function client_toggle_maximized_vertical(c)
  c.maximized_vertical = not c.maximized_vertical
  c:raise()
end

function tag_view_only(i)
  local screen = awful.screen.focused()
  local tag = screen.tags[i]
  if tag then
    tag:view_only()
  end
end

function client_move_to_tag(i)
  if client.focus then
    local tag = client.focus.screen.tags[i]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end
end

globalkeys = {}
function globalkey(mod, key, func, desc)
  local key = awful.key(mod, key, func, desc)
  for k, v in pairs(key) do
    table.insert(globalkeys, v)
  end
end

-- launch programs
globalkey({ modkey }, "r", function () awful.spawn("rofi -show run") end,
          { description = "run rofi", group = "awesome: launcher" })
globalkey({ modkey }, "w", function () awful.spawn("rofi -show window") end,
          { description = "run rofi", group = "awesome: launcher" })
globalkey({ modkey }, "p", function () awful.spawn("rofi-pass") end,
          { description = "run passmenu", group = "awesome: launcher" })
globalkey({ modkey }, "Return", function () awful.spawn(terminal) end,
          { description = "open terminal", group = "awesome: launcher" })

-- lock screen
globalkey({ modkey }, "Escape", function () os.execute("dm-tool lock") end,
          { description = "lock screen", group = "awesome: misc" })

-- hotkey help
globalkey({ modkey }, "s", hotkeys_popup.show_help,
          {description = "show help", group="awesome: misc"})

-- next layout
globalkey({ modkey, "Shift" }, "Tab", function () awful.layout.inc(1) end,
          { description = "next layout", group = "awesome: layout" })

-- next tag
globalkey({ modkey }, "Tab", awful.tag.viewnext,
          { description = "next tag", group = "awesome: tag" })

-- bind all key numbers to tags
for i = 1, 9 do
  -- view tag
  globalkey({ modkey }, "#" .. i + 9, function () tag_view_only(i) end,
            { description = "view tag #" .. i, group = "awesome: tag" })
  -- move focused client to tag
  globalkey({ modkey, "Shift" }, "#" .. i + 9, function () client_move_to_tag(i) end,
            { description = "move focused client to tag #" .. i, group = "awesome: tag" })
end

-- client focus
globalkey({ modkey }, "h", function () awful.client.focus.bydirection("left") end,
          { description = "focus left", group = "awesome: focus" })
globalkey({ modkey }, "j", function () awful.client.focus.bydirection("down") end,
          { description = "focus down", group = "awesome: focus" })
globalkey({ modkey }, "k", function () awful.client.focus.bydirection("up") end,
          { description = "focus up", group = "awesome: focus" })
globalkey({ modkey }, "l", function () awful.client.focus.bydirection("right") end,
          { description = "focus right", group = "awesome: focus" })

-- client position
globalkey({ modkey, "Shift" }, "h", function () awful.client.swap.bydirection("left") end,
          { description = "swap left", group = "awesome: client" })
globalkey({ modkey, "Shift" }, "j", function () awful.client.swap.bydirection("down") end,
          { description = "swap down", group = "awesome: client" })
globalkey({ modkey, "Shift" }, "k", function () awful.client.swap.bydirection("up") end,
          { description = "swap up", group = "awesome: client" })
globalkey({ modkey, "Shift" }, "l", function () awful.client.swap.bydirection("right") end,
          { description = "swap right", group = "awesome: client" })
globalkey({ modkey }, "o", awful.client.movetoscreen, 
          { description = "toggle display screen", group = "awesome: client" })

-- brightness control
local mybacklight_n = nil

function backlight_adjust(perc)
  local cmd = nil
  if perc > 0 then
    cmd = string.format("xbacklight -inc %d", perc)
  else
    cmd = string.format("xbacklight -dec %d", math.abs(perc))
  end

  awful.spawn.easy_async(
      cmd,
      function (sdout, stderr, reason, exitcode)
        awful.spawn.easy_async(
            "xbacklight -get",
            function (stdout, stderr, reason, exitcode)
              mybacklight_n = naughty.notify({
                  title = "Backlight",
                  text = string.format("%d%%", stdout),
                  replaces_id = mybacklight_n,
                  destroy = function () mybacklight_n = nil end
                }).id
            end
          )
      end
    )
end

globalkey({ }, "XF86MonBrightnessDown", function () backlight_adjust(-5) end,
          { description = "reduce screen brightness", group = "awesome: misc" })
globalkey({ }, "XF86MonBrightnessUp", function () backlight_adjust(5) end,
          { description = "increase screen brightness", group = "awesome: misc" })

root.keys(globalkeys)

--------------------
-- Client keys
--------------------
clientkeys = {}
function clientkey(mod, key, func, desc)
  local key = awful.key(mod, key, func, desc)
  for k, v in pairs(key) do
    table.insert(clientkeys, v)
  end
end

--  client control
clientkey({ modkey }, "x", function (c) c:kill() end,
          { description = "close window", group = "awesome: client" })
clientkey({ modkey }, "space", awful.client.floating.toggle,
          { description = "toggle floating", group = "awesome: client" })
clientkey({ modkey }, "m", client_toggle_maximized,
          { description = "toggle maximized", group = "awesome: client" })
clientkey({ modkey }, "n", function (c) c.minimized = true end,
          { description = "minimize", group = "awesome: client" })
clientkey({ modkey }, "v", client_toggle_maximized_vertical,
          { description = "toggle vertical maximized", group = "awesome: client" })
clientkey({ modkey }, "t", function (c) c.ontop = not c.ontop end,
          { description = "toggle keep on top", group = "awesome: client" })

--------------------
-- Global buttons
--------------------
root.buttons(gears.table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

--------------------
-- Client buttons
--------------------
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