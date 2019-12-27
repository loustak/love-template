local sceneman = require('lib.sceneman')
local camera = require('scenes.camera')
local autobind = require('scenes.autobind')

local base = autobind(camera())

local menu = sceneman:new('menu', base)

function menu:mousepressed()
  -- sceneman:stop():start('game')
end

function menu:swipe(x, y, button)
  self.camera:move(x, y)
end

function menu:drawcamera(dt)
  love.graphics.setColor(1, 0, 0)
  love.graphics.print('Menu scene', 170, 380)
end

return menu
