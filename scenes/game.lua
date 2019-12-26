local sceneman = require('sceneman')
local autobind = require('scenes.autobind')

local game = sceneman:new('game', autobind())

function game:keyreleased(key)
  if not self:isactive() then return end

  if key == 'p' then
    sceneman:toback():start('pause')
	elseif key == 'escape' then
		sceneman:stop():start('menu')
  end
end

function game:draw(dt)
  love.graphics.setColor(0, 1, 0)
  love.graphics.print('Game scene', 170, 380)
end

return game
