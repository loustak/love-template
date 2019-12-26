-- ctrl + shift + l to enable love2d terminal on windows

-- Debug library so it's ok to load it globally
inspect = require('inspect')
local color = require('color')
local game = require('game')

-- Initialize the random number generator
math.randomseed(os.time())

function love.run()
  -- No configurable framerate cap 
  -- currently, either max frames 
  -- CPU can handle (up to 1000), 
  -- or vsync'd if conf.lua

  -- 1 / Ticks Per Second. 
  -- It's the simulation tick rate.
  local tickRate = 1 / 60

  -- How many Frames are allowed to be skipped at 
  -- once due to lag (no "spiral of death")
  local maxFrameSkip = 0.3 * 60

  if love.load then 
    love.load(love.arg.parseGameArguments(arg), arg)
  end

  -- We don't want the first frame's 
  -- dt to include time taken by love.load.
  if love.timer then love.timer.step() end

  local lag = 0.0

  -- Main loop time.
  return function()
    -- Process events.
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == 'quit' then
          if not love.quit or not love.quit() then
            return a or 0
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end

    -- Cap number of Frames that can 
    -- be skipped so lag doesn't accumulate.
    if love.timer then
      lag = math.min(lag + love.timer.step(), tickRate * maxFrameSkip) 
    end

    while lag >= tickRate do
      if love.update then love.update(tickRate) end
      lag = lag - tickRate
    end

    if love.graphics and love.graphics.isActive() then
      love.graphics.origin()
      love.graphics.clear(love.graphics.getBackgroundColor())

      if love.draw then love.draw(lag / tickRate) end
      love.graphics.present()
    end

    -- Even though we limit tick 
    -- rate and not frame rate, 
    -- we might want to cap 
    -- framerate at 1000 frame rate 
    if love.timer then 
      love.timer.sleep(0.001)
    end
  end
end

function love.load()
  -- Setting global infos
  love.window.setTitle('Love template')
  love.window.setMode(400, 800, { vsync = true })
  -- Remove blurry pixels
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- Load the game ressources once
  game:load()
  game:start()
end

function love.update(dt)
  game:update(dt)
end

function love.draw(dt)
  game:draw(dt)
end
