local sceneman = require('lib.sceneman')

local function layers()
  local scene = {}
  scene.layers = {}

  function scene:add(name, layer)
    layer = layer or {}
    layer.name = name

    self.layers[name] = layer
  end

  function scene:get(name)
    return self.layers[name]
  end

  function scene:start()
    self:add('main')
  end

  return scene
end

return layers
