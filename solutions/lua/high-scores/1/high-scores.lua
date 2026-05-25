local function get_copy(scores)
  local copy = {}
  for k, v in pairs(scores) do copy[k] = v end
  return copy
end

local function get_top(max, scores)
  local top = {}
  local count = 0
  local sorted = get_copy(scores)
  table.sort(sorted, function(a, b) return a > b end)

  for k, v in pairs(sorted) do
    top[k] = v
    count = count + 1
    if count == max then break end
  end

  return top
end

return function(scores)
  local top = get_top(3, scores)

  return {
    scores = function(self) return scores end,
    latest = function(self) return scores[#scores] end,
    personal_best = function(self) return top[1] end,
    personal_top_three = function(self) return top end
  }
end
