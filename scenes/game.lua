local sceneman = require('lib.sceneman')
local base = require('scenes.base')

local game = sceneman:new('game', base())

function game:start()
  game.super:start()
end

function game.binds:keypressed(key)
  if not game:isactive() then return end

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
