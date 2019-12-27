local actum = require('lib.actum')

local lovebind = {}
lovebind.swipebutton = {}

-- Mouse events
lovebind.mousepressed = actum:event()

function love.mousepressed(...)
  lovebind.mousepressed:trigger(...)
  lovebind:startswipe(...)
end

lovebind.mousereleased = actum:event()

function love.mousereleased(...)
  lovebind.mousereleased:trigger(...)
  lovebind:endswipe(...)
end

lovebind.mousemoved = actum:event()

function love.mousemoved(...)
  lovebind.mousemoved:trigger(...)
  lovebind:handleswipe(...)
end

-- Custom event to handle swipes
lovebind.swipe = actum:event()

function lovebind:startswipe(x, y, button)
  local obj = {}
  obj.startx = x
  obj.starty = y
  self.swipebutton[button] = obj
end

function lovebind:handleswipe(x, y)
  for button, obj in pairs(self.swipebutton) do
    local vx = obj.startx - x
    local vy = obj.starty - y
    obj.startx = x
    obj.starty = y
    self.swipe:trigger(vx, vy, button)
  end
end

function lovebind:endswipe(x, y, button)
  self.swipebutton[button] = nil
end

function lovebind:isswaping(button)
  return self.swipebutton[button] ~= nil
end

-- Keyboard events
lovebind.keypressed = actum:event()

function love.keypressed(...)
  lovebind.keypressed:trigger(...)
end

lovebind.keyreleased = actum:event()

function love.keyreleased(...)
  lovebind.keyreleased:trigger(...)
end

return lovebind
