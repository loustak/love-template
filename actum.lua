-- local inspect = require("../cadence/lib/inspect")
local actum = { }

actum.key = { 
    pressed = { },
    released = { }
}
actum.mouse = { 
    moved = { },
    pressed = { },
    released = { },
    wheel = { }
}

function love.keypressed(key, scancode, isrepeat)
    actum:keyfor(actum.key.pressed, key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    actum:keyfor(actum.key.released, key, scancode)
end

function actum:keyfor(actions, key, scancode, isrepeat)
    for keyname, funcs in pairs(actions) do
        if keyname == key then
            for _, func in pairs(funcs) do
                func(key, scancode, isrepeat)
            end
        end
    end
end

function love.mousepressed(x, y, button, istouch)
    actum:mousefor(actum.mouse.pressed, x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    actum:mousefor(actum.mouse.released, x, y, button, istouch)
end

function actum:mousefor(actions, x, y, button, istouch)
    for buttonname, funcs in pairs(actions) do
        if buttonname == button then
            for _, func in pairs(funcs) do
                func(x, y, button, istouch)
            end
        end
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    for _, func in pairs(actum.mouse.moved) do
        func(x, y, dx, dy, istouch)
    end
end

function love.wheelmoved(x, y)
    for _, func in pairs(actum.mouse.wheel) do
        func(x, y)
    end
end

function actum:keypressed(key, func)
    return self:construct(self.key.pressed, key, func)
end

function actum:keyreleased(key, func)
    return self:construct(self.key.released, key, func)
end

function actum:mousepressed(button, func)
    return self:construct(self.mouse.pressed, button, func)
end

function actum:mousereleased(button, func)
    return self:construct(self.mouse.released, button, func)
end

function actum:mousemoved(func)
    local action = self.mouse.moved
    local index = #action + 1
    action[index] = func

    return {
        enable = function()
            action[index] = func
        end,
        disable = function()
            action[index] = nil
        end
    }
end

function actum:wheelmoved(func)
    local action = self.mouse.wheel
    local index = #action + 1
    action[index] = func

    return {
        enable = function()
            action[index] = func
        end,
        disable = function()
            action[index] = nil
        end
    }
end

function actum:construct(actions, event, func)
    if actions[event] == nil then
        actions[event] = { }
    end

    local index = #actions[event] + 1
    actions[event][index] = func

    return {
        enable = function()
            actions[event][index] = func
        end,
        disable = function()
            actions[event][index] = nil
        end
    }
end

return actum