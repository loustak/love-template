local actum = require('actum')
local lovebind = require('love_bind')
local sceneman = require('sceneman')
local camera = require('camera')

require('scenes.menu')
require('scenes.game')
require('scenes.pause')

local game = {}

function game:load()
  -- Things that should be done only
  -- once in a game should be done here,
  -- such as loading game ressources and
  -- things like that
  sceneman:loadall()

  love.graphics.setBackgroundColor(1, 1, 1)

  lovebind.keypressed:bind(function(key)
    if key == 'r' then
      self:restart()
    end
  end)
end

function game:start()
  self.fpsFont = love.graphics.newFont(12)
  self.fps = 0

  sceneman:start('menu')
end

function game:restart()
  -- Use it for debug purpose
  sceneman:stopall()
  sceneman:quitall()
  self:start()
  print('restart')
end

function game:quit()
  -- Unload stuff here
  sceneman:quit()
  love.event.quit(0)
end

function game:update(dt)
  sceneman:update(dt)

  -- Update fps
  local rdt = love.timer.getDelta()
  self.fps = math.floor(1 / rdt)
end

function game:draw(dt)
  camera:set()
  sceneman:draw(dt)
  camera:unset()

  self:drawFPS()
end

function game:drawFPS()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(self.fpsFont)
  love.graphics.print(self.fps, 15, 15)
  love.graphics.setColor(1, 1, 1)
end

return game
