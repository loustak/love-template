local lens = {}

function lens:newcamera()
  local camera = {}

  function camera:init()
    self.x = 0
    self.y = 0
    self.scaleX = 1
    self.scaleY = 1
    self.rotation = 0
    return self
  end

  function camera:reset()
    print('camera reset')
    self:init()
    return self
  end

  function camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(self.scaleX, self.scaleY)
    love.graphics.translate(-self.x, -self.y)
  end

  function camera:unset()
    love.graphics.pop()
  end

  function camera:move(dx, dy)
    self.x = self.x + (dx or 0)
    self.y = self.y + (dy or 0)
  end

  function camera:rotate(dr)
    self.rotation = self.rotation + dr
  end

  function camera:scale(sx, sy)
    sx = sx or 1
    self.scaleX = self.scaleX * sx
    self.scaleY = self.scaleY * (sy or sx)
  end

  function camera:getPosition()
    return self.x, self.y
  end
  
  function camera:setPosition(x, y)
    self.x = x or self.x
    self.y = y or self.y
  end

  function camera:center(x, y)
    local xx = (x - love.graphics.getWidth() / 2)
    local yy = (y - love.graphics.getHeight() / 2)

    self:setPosition(xx, yy)
  end

  function camera:screenToWorld(x, y)
    local xx = x + self.x
    local yy = y + self.y

    return xx, yy
  end

  return camera:init()
end

return lens
