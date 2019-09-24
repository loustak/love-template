local bump = require("lib.bump")
local lume = require("lib.lume")
local res = require("res")
local camera = require("camera")
local color = require("color")

local score = require("score")
local Cursor = require("cursor")
local Bar = require("bar")

-- A playable level
local Level = { }

function Level:new()
  local inst = { }
  setmetatable(inst, self)
  self.__index = self
  return inst
end

function Level:init(difficulty)
  self.bumpWorld = bump.newWorld(16)

  self.difficulty = difficulty
  self.difficulty.level = self

  score:init(self.difficulty.scoreColor)

  -- All the cursors
  self.cursorList = { }
  -- All the bars created
  self.barList = { }

  -- All the infos about the bars
  self.barInfo = {
    w = 24,
    h = 300,
    speed = 370
  }

  self.difficulty:onStart()

  return self
end

function Level:getScore()
  return score.value
end

function Level:clean()
  -- Unallocate ressources
  self:purgeCollisions()
end

function Level:restart()
  self:clean()
  self:init(self.difficulty)
end

function Level:callOnChangeFunc()
  local func = self.difficulty.onChange
  if func ~= nil then
    return func()
  end
  return nil
end

function Level:callOnUpdateFunc(dt)
  local func = self.difficulty.onUpdate
  if func ~= nil then
    return func(dt)
  end
  return nil
end

function Level:callOnUpdateBarFunc(bar, dt)
  local func = self.difficulty.onUpdateBar
  if func ~= nil then
    return func(bar, dt)
  end
  return nil
end

function Level:callOnScoreFunc(cursor)
  local func = self.difficulty.onScore
  if func ~= nil then
    return func(cursor)
  end
  return nil
end

function Level:purgeCollisions()
  -- Remove all items from the bump world
  local items = self.bumpWorld:getItems()
  for _, item in ipairs(items) do
    self.bumpWorld:remove(item)
  end
end

function Level:addCursor(cursor)
  table.insert(self.cursorList, cursor)
end

function Level:addBar(bar)
  table.insert(self.barList, bar)
end

function Level:spawnBar(prevbar)
  self.difficulty:spawnBar(prevbar)
end

function Level:getClosestCursor(x, y)
  local mindist = nil
  local closestCursor = nil

  for _, cursor in pairs(self.cursorList) do
    local cx, cy = cursor.x, cursor.y
    local dist = lume.distance(x, y, cx, cy)
    if mindist == nil or dist < mindist then
      mindist = dist
      closestCursor = cursor
    end
  end

  return closestCursor
end

function Level:mousepressed(x, y, button, istouch)
  if istouch or button == 1 then
    local cursor = self:getClosestCursor(x, y)
    if cursor ~= nil then
      cursor:pressed()
    end
  end
end

function Level:mousereleased(x, y, button, istouch)
  if istouch or button == 1 then
    local cursor = self:getClosestCursor(x, y)
    if cursor ~= nil then
      -- For tests purposes
      -- self:goodPress(cursor)
      -- return
      cursor:released()
    end
  end
end

function Level:goodPress(cursor)
  score.value = score.value - 1
  self:callOnChangeFunc()
  self:callOnScoreFunc(cursor)
end

function Level:badPress(cursor)
  -- self:restart()
end

function Level:update(dt)
  score:update(dt)

  -- Update the cursor
  for key, cursor in pairs(self.cursorList) do
    cursor:update(dt)
  end

  -- Call the difficulty's update function
  self:callOnUpdateFunc(dt)

  -- Update bars and delete 
  -- the one out of screen
  for key, bar in pairs(self.barList) do
    print(bar)
    self:callOnUpdateBarFunc(bar, dt)
    local toDelete = bar:update(dt)

    if toDelete then
      bar:delete()
      self.barList[key] = nil
    end
  end
end

function Level:draw(dt)
  score:draw()

  for _, bar in pairs(self.barList) do
    bar:draw()
  end

  for _, cursor in pairs(self.cursorList) do
    cursor:draw()
  end
end

return Level
