return function(size)
  local grid = {}

  for i = 1, size do
    grid[i] = {}

      for j = 1, size do
          grid[i][j] = 0
      end
  end

  local x = 1
  local y = 1

  local min = 1
  local max = size

  local direction = 0

  for n = 1, size * size do
    local needs_direction_change = false

    local current_x = x
    local current_y = y

    while grid[x][y] ~= 0 do
      if needs_direction_change then direction = direction + 1 end

      x = current_x
      y = current_y

      if y < max and direction % 4 == 0 then y = y + 1 end
      if x < max and direction % 4 == 1 then x = x + 1 end
      if y > min and direction % 4 == 2 then y = y - 1 end
      if x > min and direction % 4 == 3 then x = x - 1 end

      needs_direction_change = true
    end

    grid[x][y] = n
  end

  return grid
end
