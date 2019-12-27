local sceneman = require('lib.sceneman')
local camera = require('scenes.camera')
local autobind = require('scenes.autobind')

local base = autobind(camera())

local menu = sceneman:new('menu', base)

function menu:mousepressed(x, y)
  sceneman:stop():start('game')
end

function menu:drawcamera(dt)
  love.graphics.setColor(1, 0, 0)
  love.graphics.print('Menu scene', 170, 380)
end

function menu:stop()
  self:autounbind()
  self.camera:setPosition(0, 0)
end

return menu
