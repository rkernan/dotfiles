local awful = require("awful")

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

run_once("udiskie")
run_once("nm-applet")
run_once("volumeicon")
run_once("blueman-applet")
run_once("cbatticon")
run_once("light-locker --lock-on-suspend")
