local camera = require("camera")

local game = { }

function game:load()
  -- Things that should be done only
  -- once in a game should be done here,
  -- such as loading game ressources and
  -- things like that.
  love.graphics.setBackgroundColor(1, 1, 1)
end

function game:start()
  self.fpsFont = love.graphics.newFont(12)
  self.fps = 0
  self.paused = false
  self.previousWindowTitle = ""
end

function game:restart()
end

function game:quit()
  love.event.quit(0)
end

function game:mousepressed(x, y, button, istouch)
end

function game:mousereleased(x, y, button, istouch)
end

function game:keypressed(key, scancode, isrepeat)
  if key == "r" then
    self:restart()
  elseif key == "escape" then
    self:quit()
  end
end

function game:keyreleased(key)
  if key == "p" then
    self:pause()
  end
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

  -- Draw the currently beeing played level

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
