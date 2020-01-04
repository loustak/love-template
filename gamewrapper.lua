local actum = require('lib.actum')
local lovebind = require('lib.love_bind')
local sceneman = require('lib.sceneman')

require('scenes.menu')
require('scenes.game')
require('scenes.pause')

local gamewrapper = {}

function gamewrapper:load()
  sceneman:loadall()

  love.graphics.setBackgroundColor(1, 1, 1)
  self.fpsFont = love.graphics.newFont(12)

  lovebind.keypressed:bind(function(key)
    if key == 'r' then
      self:restart()
    end
  end)
end

function gamewrapper:start()
  self.fps = 0

  sceneman:start('menu')
end

function gamewrapper:restart()
  -- Use it for debug purpose
  sceneman:stopall()
  sceneman:quitall()
  self:start()
  print('restart')
end

function gamewrapper:quit()
  -- Unload stuff here
  sceneman:quitall()
  love.event.quit(0)
end

function gamewrapper:update(dt)
  sceneman:update(dt)

  -- Update fps
  local rdt = love.timer.getDelta()
  self.fps = math.floor(1 / rdt)
end

function gamewrapper:draw(dt)
  sceneman:draw(dt)

  self:drawFPS()
end

function gamewrapper:drawFPS()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(self.fpsFont)
  love.graphics.print(self.fps, 15, 15)
  love.graphics.setColor(1, 1, 1)
end

return gamewrapper
