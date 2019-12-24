local sceneman = require('sceneman')
local lovebind = require('love_bind')

local pause = sceneman:new('pause')

function pause:start()
  self.a = lovebind.keyreleased:bind(function(key)
    if key == 'p' then
      sceneman:stop():tofront('game')
    end
  end)

  print('start pause')
end

function pause:draw(dt)
  love.graphics.setColor(0, 0, 1)
  love.graphics.print('Pause scene', 170, 380)
end

function pause:stop()
  self.a:unbind()
  print('clean pause')
end

return pause
