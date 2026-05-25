local function get_top(max, scores)
  local sorted = {}
  table.move(scores, 1, #scores, 1, sorted)
  table.sort(sorted, function(a, b) return a > b end)
  while #sorted > max do table.remove(sorted) end
  return sorted
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
