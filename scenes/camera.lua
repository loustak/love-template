local lens = require('lib.lens')

local function camera(base)
  local scene = base or {}
  scene.camera = lens:newcamera()

  function scene:drawbefore() end
  function scene:drawcamera() end
  function scene:drawafter() end

  function scene:draw(...)
    self:drawbefore(...)

    self.camera:set()
    self:drawcamera(...)
    self.camera:unset()

    self:drawafter(...)
  end

  return scene
end

return camera
