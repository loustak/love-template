local sceneman = require('sceneman')

local base = sceneman:new()
base.binds = {}

function base:autobind(action)
  local index = #self.binds
  self.binds[index + 1] = action
end

return base
