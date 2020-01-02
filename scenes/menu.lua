local sceneman = require('lib.sceneman')
local base = require('scenes.base')

local menu = sceneman:new('menu', base)

function menu:mousepressed(x, y)
  sceneman:stop():start('game')
end

function menu.autobind:keypressed(key)

  if key == 'd' then
    menu:cam('main'):move(20)
  end
  if key == 'f' then
    menu:cam('other'):move(0, 10)
  end
end

function menu.cameras.main()
  love.graphics.setColor(1, 0, 0)
  love.graphics.print('Menu scene', 170, 380, 0, 3, 3)
end

return menu
