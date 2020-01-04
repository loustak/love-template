local sceneman = require('lib.sceneman')
local base = require('scenes.base')

local pause = sceneman:new('pause', base())

function pause.binds:keypressed(key)
  if not pause:isactive() then return end

  if key == 'p' then
    sceneman:stop():tofront('game')
  end
end

function pause:draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.print('Pause scene', 170, 380)
end

return pause
