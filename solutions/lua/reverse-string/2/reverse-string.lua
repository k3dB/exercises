return function(s)
  -- Built-in way (exercise in reading documentation):
  --return string.reverse(s)

  -- Manual way (exercise in how to implement):
  local reversed = ''

  for i = #s, 1, -1 do
    reversed = reversed .. s:sub(i, i)
  end

  return reversed
end
