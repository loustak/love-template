local sceneman = require('lib.sceneman')
local lovebind = require('lib.love_bind')

local _cameras = require('scenes.cameras')
local _layers = require('scenes.layers')
local _autobind = require('scenes.autobind')

local function base()
  local scene = {}
  scene.cameras = _cameras()
  scene.layers = _layers()
  scene.autobind = _autobind()

  function scene:start()
    self.cameras:start()
    self.layers:start()
    self.autobind:start()
  end

  function scene:cam(name)
    return self.cameras:get(name)
  end

  function scene:layer(name)
    return self.layers:get(name)
  end

  function scene:draw(...)
    self.cameras:draw(...)
  end

  function scene:stop()
    self.cameras:stop()
    self.autobind:stop()
  end

  return scene
end

return base()
