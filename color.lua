local color = { }

function color.print(color, mode)
  mode = mode or "255"
  local red = color[1]
  local green = color[2]
  local blue = color[3]
  local alpha = color[4]

  if mode == "255" then
    red = red * 255
    green = green * 255
    blue = blue * 255
  end

  print("r: " .. red .. 
        ", g: " .. green .. 
        ", b: " .. blue .. 
        ", a: " .. alpha)
end

function color.rgb(red, green, blue, alpha)
  -- Convert rgb color to 0-1 color
  alpha = alpha or 1
  return { red / 255, green / 255, blue / 255, alpha }
end

function color.hsv(hue, saturation, value)
  -- Create a 0-1 color from hsv
  if saturation <= 0 then 
    return color.rgb(value, value, value)
  end
  hue, saturation, value = hue / 256 * 6, saturation / 255, value / 255
  local c = value * saturation
  local x = (1 - math.abs((hue % 2) - 1)) * c
  local m, r, g, b = (value - c), 0, 0, 0
  if hue < 1     then r, g, b = c, x, 0
  elseif hue < 2 then r, g, b = x, c, 0
  elseif hue < 3 then r, g, b = 0, c, x
  elseif hue < 4 then r, g, b = 0, x, c
  elseif hue < 5 then r, g, b = x, 0, c
  else                r, g, b = c, 0, x end
  return color.rgb((r + m) * 255, (g + m) * 255, (b + m) * 255)
end

function color.hex(hex)
  -- Convert hex color to 0-1 color
  hex = hex:gsub("#", "")
  return color.rgb(
  tonumber("0x"..hex:sub(1, 2)), 
  tonumber("0x"..hex:sub(3, 4)), 
  tonumber("0x"..hex:sub(5, 6)))
end

function color.duplicate(color)
  return { color[1], color[2], color[3], color[4] }
end

return color
