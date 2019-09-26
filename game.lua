local actum = require("actum")
local camera = require("camera")

local game = { }

function game:load()
  -- Things that should be done only
  -- once in a game should be done here,
  -- such as loading game ressources and
  -- things like that.
  love.graphics.setBackgroundColor(1, 1, 1)

  actum:keypressed("p", function() self:pause() end)
  actum:keypressed("r", function() self:restart() end)
  actum:keypressed("escape", function() self:quit() end)
  actum:keyreleased("a", function() print("ok") end)

  actum:mousepressed(1, function() self.pressed = true end)
  actum:mousereleased(1, function() self.pressed = false end)

  actum:mousemoved(function(x, y, dx, dy)
    print(x .. " " .. y)
    if self.pressed then
      camera:move(-dx, -dy)
    end
  end)
end

function game:start()
  self.fpsFont = love.graphics.newFont(12)
  self.fps = 0
  self.paused = false
  self.previousWindowTitle = ""

  self.pressed = false
end

function game:restart()
  print("restart")
  self:start()
end

function game:quit()
  love.event.quit(0)
end

function game:mousepressed(x, y, button, istouch)
end

function game:mousereleased(x, y, button, istouch)
end

function game:pause()
  self.paused = not self.paused
  if self.paused then
    self.previousWindowTitle = love.window.getTitle()
    love.window.setTitle("PAUSE")
  else
    love.window.setTitle(self.previousWindowTitle)
  end
end

function game:update(dt)
  -- Don't update the game when the game is paused
  if not self.paused then
    -- Place game logic here
  end

  -- Update fps
  local rdt = love.timer.getDelta()
  self.fps = math.floor(1 / rdt)
end

function game:draw(dt)
  -- Camera transform
  camera:set()

  love.graphics.setColor(0, 0, 0)
  love.graphics.print("HELLO WORLD", 170, 380)

  -- Stop camera transform
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
