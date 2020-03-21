local awful, naughty = awful, naughty

local ReusableNotification = {}
ReusableNotification.__index = ReusableNotification

function ReusableNotification.new(title)
  local self = setmetatable({}, ReusableNotification)
  self.title = title
  self.id = nil
  return self
end

function ReusableNotification.notify(self, text)
  self.id = naughty.notify({
      replaces_id = self.id,
      title = self.title,
      text = text,
      destroy = function() self.id = nil end
    }).id
end

--------------------
-- Backlight
--------------------
local backlight = ReusableNotification.new("Brightness")

function backlight_adjust(perc)
  local cmd = nil
  if perc > 0 then
    cmd = string.format("xbacklight -inc %d", perc)
  else
    cmd = string.format("xbacklight -dec %d", math.abs(perc))
  end

  awful.spawn.easy_async(cmd,
      function (sdout, stderr, reason, exitcode)
        awful.spawn.easy_async("xbacklight -get",
            -- pop notification
            function (stdout, stderr, reason, exitcode)
              backlight:notify(string.format("%d%%", stdout))
            end
          )
      end
      )
end

--------------------
-- Volume
--------------------

local volume = ReusableNotification.new("Volume")

function volume_toggle_mute()
  awful.spawn.easy_async(
      "pamixer --toggle-mute",
      function (stdout, stderr, reason, exitcode)
        -- update volume widget
        theme.volume.update()
        -- pop notification
        awful.spawn.easy_async(
            "pamixer --get-mute",
            function (stdout, stderr, reason, exitcode)
              if string.gsub(stdout, '%s+', '') == "true" then
                volume:notify("Muted")
              else
                volume:notify("Unmuted")
              end
            end
          )
      end
    )
end

function volume_adjust(perc)
  local cmd = nil
  if perc > 0 then
    cmd = string.format("pamixer --increase %d", perc)
  else
    cmd = string.format("pamixer --decrease %d", math.abs(perc))
  end
  
  awful.spawn.easy_async(cmd,
      function (stdout, stderr, reason, exitcode)
        -- update volume widget
        theme.volume.update()
        -- pop notification
        awful.spawn.easy_async(
            "pamixer --get-volume",
            function (stdout, stderr, reason, exitcode)
              volume:notify(string.format("%d%%", stdout))
            end
          )
      end
    )
end
