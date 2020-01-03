local _timer = require('timer')

local function timers()
  local scene = {}
  scene.list = {}

  function scene:add(trigger, func)
    local timer = _timer:new(trigger, func)

    local size = #self.list
    timer.index = size + 1
    self.list[timer.index] = timer

    return timer
  end

  function scene:update(delay)
    for _, timer in pairs(self.list) do
      timer:update(delay)
    end
  end

  function scene:stop()
    for _, timer in pairs(self.list) do
      timer = nil
    end

    self.list = {}
  end

  return scene
end

return timers
