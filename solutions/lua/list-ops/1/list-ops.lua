local function reduce(xs, value, f)
  local reducedValue = value

  for _, item in ipairs(xs) do
    reducedValue = f(item, reducedValue)
  end

  return reducedValue
end

local function map(xs, f)
  local mappedItems = {}

  for key, value in ipairs(xs) do
    mappedItems[key] = f(value)
  end

  return mappedItems
end

local function filter(xs, pred)
  local filteredItems = {}
  local index = 1

  for _, value in ipairs(xs) do
    if pred(value) then
      filteredItems[index] = value
      index = index + 1
    end
  end

  return filteredItems
end

return { map = map, reduce = reduce, filter = filter }
