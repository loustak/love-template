local lovebind = require('love_bind')
local inspect = require('inspect')

local function autobind()
  local scene = {}
  scene.binds = {}

  function scene:mousepressed() end
  function scene:mousereleased() end
	function scene:mousemoved() end
  function scene:keypressed() end
  function scene:keyreleased() end

  function scene:bind(bind)
    local index = #self.binds
    self.binds[index + 1] = bind
    return bind
  end

  function scene:autobind()
    self:bind(
      lovebind.mousepressed:bind(function(...)
        self:mousepressed(...)
      end)
    )

    self:bind(
      lovebind.mousereleased:bind(function(...)
        self:mousepressed(...)
      end)
    )

    self:bind(
      lovebind.keypressed:bind(function(...)
        self:keypressed(...)
      end)
    )
		
    self:bind(
      lovebind.keyreleased:bind(function(...)
        self:keyreleased(...)
      end)
    )
  end

  function scene:autounbind()
    for _, bind in pairs(self.binds) do
      bind:unbind()
    end

		self.binds = {}
  end

	function scene:start()
		self:autobind()
	end

	function scene:stop()
		self:autounbind()
	end

  return scene
end

return autobind
