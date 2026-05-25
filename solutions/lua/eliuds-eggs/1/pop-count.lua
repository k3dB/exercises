local PopCount = {}

local function is_odd(number)
  return number % 2 ~= 0
end

function PopCount.egg_count(number)
  count = 0
  current = number

  while current > 0 do
    if is_odd(current) then
      count = count + 1
      current = current - 1
    end

    current = current / 2
  end

  return count
end

return PopCount
