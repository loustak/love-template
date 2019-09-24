
-- Used to keep track of all ressources of the game
local res = { }
res.path = { }
res.sprites = { }

function res:load()
end

function res:loadSprites(sprites)
    local pathSprites = self:getPathSprites()
    for _, sprite in pairs(sprites) do
        local img = love.graphics.newImage(pathSprites .. sprite .. ".png")
        self:addSprite(sprite, img)
    end
end

res.path.assets = "assets/"

function res:getPathAssets()
    return self.path.assets
end

res.path.sprites = res:getPathAssets() .. "sprites/"

function res:getPathSprites()
    return self.path.sprites
end

res.path.maps = res:getPathAssets() .. "maps/"

function res:getPathMaps()
    return self.path.maps
end

res.path.tilesets = res:getPathAssets()

function res:getSprites()
    return self.sprites
end

function res:getSprite(spriteName)
    local sprite = self.sprites[spriteName]
    assert(sprite, "sprite not found: " .. spriteName)
    return sprite
end

function res:addSprite(spriteName, img)
    local sprite = self.sprites[spriteName]
    if sprite ~= nil then
        error("sprite with this name already exists: " .. spriteName)
    end
    self.sprites[spriteName] = img
end

return res
