local sceneman = require('sceneman')
local autobind = require('scenes.autobind')

local menu = sceneman:new('menu', autobind())

function menu:mousepressed()
  sceneman:stop():start('game')
end

function menu:draw(dt)
  love.graphics.setColor(1, 0, 0)
  love.graphics.print('Menu scene', 170, 380)
end

return menu
