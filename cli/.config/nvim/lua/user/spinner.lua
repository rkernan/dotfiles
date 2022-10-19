Spinner = {
  timer = nil,
  interval = 130,
  frame = 1,
  frames = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
}

function Spinner:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Spinner:start()
  if not self.timer then
    self.timer = vim.loop.new_timer()
    self.frame = 1
    self.timer:start(self.interval, self.interval, vim.schedule_wrap(function () self:next() end))
  end
end

function Spinner:next()
  self.frame = self.frame % #self.frames + 1
end

function Spinner:get()
  if self.timer then
    return self.frames[self.frame]
  end
end

function Spinner:stop()
  if self.timer then
    self.timer:stop()
    self.timer = nil
    self.frame = 1
  end
end

return Spinner
