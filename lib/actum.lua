local actum = {}
actum.events = {}

function actum:clear()
  self.events = {}
end

function actum:newaction(func)
  local action = {}
  action.func = func
  action.enabled = true

  function action:enable()
    self.enabled = true
  end

  function action:disable()
    self.enabled = false
  end

  function action:toggle()
    self.enabled = not self.enabled
  end

  return action
end

function actum:newevent()
  local event = {}
  event.actions = {}
  event.unbinded = {}

  function event:clear()
    for _, action in pairs(self.actions) do
      action = nil
    end

    self.actions = {}
  end

  function event:bind(func)
    local action = actum:newaction(func)

    function action:unbind()
      table.remove(event.actions, self.index)
    end

    local index = #self.actions + 1
    action.index = index
    self.actions[index] = action
    return action
  end

  function event:trigger(...)
    for i = 1, #self.actions do
      local action = self.actions[i]
      if action and action.enabled then
        action.func(...)
      end
    end
  end

  return event
end

function actum:event()
  local event = self:newevent()
  local index = #self.events + 1
  self.events[index] = event
  return event
end

function actum:clean()
  for _, event in ipairs(self.events) do
    for _, action in ipairs(event.actions) do
      action:unbind()
    end
    event = {}
  end

  self.events = {}
end

return actum
