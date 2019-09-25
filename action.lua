local action = { }
action.callbacks = {
    pressed = { },
    released = { }
}

action.KEY_PRESSED = 0
action.KEY_RELEASED = 1

function love.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
end

function love.keypressed(key, scancode, isrepeat)
    for key, callback in pairs(action.callbacks.pressed) do
        local func = callback.func
        local caller = callback.caller
        print(caller.func)
        caller:func(key, scancode, isrepeat)
    end
end

function love.keyreleased(key, scancode)
    for key, callback in pairs(action.callbacks.released) do
        callback.func(key, scancode, isrepeat)
    end
end

function action.register(event, callback)
    if event == action.KEY_PRESSED then
        table.insert(action.callbacks.pressed, callback)
    elseif event == action.KEY_RELEASED then
        table.insert(action.callbacks.released, callback)
    end
end

return action