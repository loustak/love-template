local _timer = {}

function _timer:new(trigger, func)
  local timer = {}

  timer.count = 0
  timer.started = false
  timer.trigger = trigger
  timer.triggered = false
  timer.func = func

  function timer:start()
    self.started = true
    return self
  end

  function timer:stop()
    self.started = false
    return self
  end

  function timer:toggle()
    self.started = not self.started
    return self
  end

  function timer:isstarted()
    return self.started
  end

  function timer:update(delay)
    if not self.started then return end

    self.count = self.count + delay

    if self.count >= self.trigger and 
      not self:wastriggered() then
      func()
      self.triggered = true
    end

    return self
  end

  function timer:wastriggered()
    return self.triggered
  end

  function timer:reset()
    self.count = 0
    self.triggered = false
    return self
  end

  return timer
end

return _timer
