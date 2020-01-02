local sceneman = require('lib.sceneman')
local lens = require('lib.lens')

local function sort(a, b)
  print('ok')
  return a.z < b.z
end

local function cameras()
  local scene = {}
  scene._cameras = {}
  scene._sorted = {}

  function scene:add(name, z)
    local camera = lens:newcamera()
    camera.name = name
    camera.z = z or 0

    self._cameras[name] = camera
    local size = #self._sorted
    self._sorted[size + 1] = camera
    self:sort()
  end

  function scene:get(name)
    return self._cameras[name]
  end

  function scene:start()
    self:add('main', 0)
  end

  function scene:sort()
    table.sort(self._sorted, sort)
  end

  function scene:draw(...)
    for _, camera in ipairs(self._sorted) do
      camera:set()
      self[camera.name](camera, ...)
      camera:unset()
    end
  end

  function scene:stop(...)
    self._cameras = {}
    self._sorted = {}
  end

  return scene
end

return cameras
