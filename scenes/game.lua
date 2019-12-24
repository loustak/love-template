local sceneman = require('sceneman')
local lovebind = require('love_bind')

local game = sceneman:new('game')

function game:start()
  self.a = lovebind.keyreleased:bind(function(key)
    if not self:isactive() then return end

    if key == 'p' then
      sceneman:toback():start('pause')
    end
  end)

  print('start game')
end

function game:tofront()
  print('tofront game')
end

function game:draw(dt)
  love.graphics.setColor(0, 1, 0)
  love.graphics.print('Game scene', 170, 380)
end

function game:toback()
  print('toback game')
end

function game:stop()
  self.a:unbind()
  print('clean game')
end

return game
