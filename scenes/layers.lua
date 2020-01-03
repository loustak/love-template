local sceneman = require('lib.sceneman')

local function sort(a, b)
  return a.z < b.z
end

local function layers()
  local scene = {}
  scene._layers = {}
  scene._sorted = {}

  function scene:add(name, z)
    local layer = {}
    layer.name = name
    layer.z = z or 0

    self._layers[name] = layer
    local size = #self._sorted
    self._sorted[size + 1] = layer
    self:sort()
  end

  function scene:get(name)
    return self._layers[name]
  end

  function scene:sort()
    table.sort(self._sorted, sort)
  end

  function scene:start()
    self:add('main', 1)
    self:add('second', 2)
    self:add('third', 3)
  end

  function scene:draw(...)
    for _, layer in ipairs(self._sorted) do
      self[layer.name](layer, ...)
    end
  end

  function scene:stop()
    for _, layer in pairs(self._layers) do
      layer = nil
    end
    for _, layer in pairs(self._sorted) do
      layer = nil
    end

    self._layers = {}
    self._sorted = {}
  end

  return scene
end

return layers
