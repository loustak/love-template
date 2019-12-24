local sceneman = require('sceneman')
local lovebind = require('love_bind')

local menu = sceneman:new('menu')

function menu:start()
  self.a = lovebind.mousepressed:bind(function()
    print('click')
    sceneman:stop():start('game')
  end)

  print('start menu')
end

function menu:draw(dt)
  love.graphics.setColor(1, 0, 0)
  love.graphics.print('Menu scene', 170, 380)
end

function menu:stop()
  self.a:unbind()
  print('stop menu')
end

return menu
