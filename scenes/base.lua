local sceneman = require('lib.sceneman')
local lovebind = require('lib.love_bind')
local lens = require('lib.lens')

local _layers = require('scenes.layers')
local _autobind = require('scenes.autobind')
local _timers = require('scenes.timers')

local function base()
  local scene = {}
  scene.layers = _layers()
  scene.binds = _autobind()
  scene.timers = _timers()

  function scene:start()
    self.binds:start()
    self.layers:start()
    self.maincam = lens:newcamera()
  end

  function scene:layer(name)
    return self.layers:get(name)
  end

  function scene:update(delay)
    self.timers:update(delay)
  end

  function scene:draw(...)
    self.maincam:set()
    self.layers:draw(...)
    self.maincam:unset()
  end

  function scene:stop()
    self.binds:stop()
    self.layers:stop()
    self.timers:stop()
  end

  return scene
end

return base
