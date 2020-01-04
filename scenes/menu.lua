local sceneman = require('lib.sceneman')
local base = require('scenes.base')

local menu = sceneman:new('menu', base())

function menu:start()
  menu.super:start()
  menu.display = false
end

function menu.binds:mousepressed(x, y, button)
  if button == 1 then
    print('start timer')
    menu.timers:add(1, function()
      print('end timer')
      menu.display = true
    end):start()
  end

  if button == 2 then
    sceneman:stop():start('game')
  end
end

function menu.binds:keypressed(key)
  if key == 'd' then
    menu.maincam:move(20)
  end
end

function menu.layers.main()
  love.graphics.setColor(1, 0, 0)
  love.graphics.print('Main layer', 170, 380, 0, 3, 3)
end

function menu.layers.second()
  love.graphics.setColor(0, 1, 0)
  love.graphics.print('Second layer', 170, 380, 0, 3, 3)
end

function menu.layers.third()
  -- This layer is detached from the camera
  menu.maincam:unset()

  love.graphics.setColor(0, 0, 1)
  love.graphics.print('Third layer', 170, 380, 0, 3, 3)

  if menu.display then
    love.graphics.setColor(0, 0, 1)
    love.graphics.print('OK', 50, 150, 0, 3, 3)
  end

  menu.maincam:set()
end

return menu
