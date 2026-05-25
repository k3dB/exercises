return function(config)
  local clockwise_headings = { 'north', 'east', 'south', 'west' }

  function advance()
    if config.heading == 'north' then config.y = config.y + 1 end
    if config.heading == 'south' then config.y = config.y - 1 end
    if config.heading == 'east'  then config.x = config.x + 1 end
    if config.heading == 'west'  then config.x = config.x - 1 end
  end

  function rotateRight()
    local index = 1

    for i = 1, #clockwise_headings do
      index = i
      if clockwise_headings[index] == config.heading then break end
    end

    if index < #clockwise_headings then
      config.heading = clockwise_headings[index + 1]
    else
      config.heading = clockwise_headings[1]
    end
  end

  function rotateLeft()
    local index = 1

    for i = 1, #clockwise_headings do
      index = i
      if clockwise_headings[index] == config.heading then break end
    end

    if index == 1 then
      config.heading = clockwise_headings[#clockwise_headings]
    else
      config.heading = clockwise_headings[index - 1]
    end
  end

  function config:move(commands)
    for i = 1, #commands do
      local command = commands:sub(i, i)

      if     command == 'A' then advance()
      elseif command == 'R' then rotateRight()
      elseif command == 'L' then rotateLeft()
      else   error("Invalid command")
      end
    end
  end

  return config
end
