local get_code = function(count, c)
  if count == 1 then return c end
  return string.format("%d%s", count, c)
end

return {
  encode = function(s)
    local coded   = ""
    local current = s:sub(1, 1)
    local count   = 1

    for i = 2, #s do
      local c = s:sub(i, i)
      if c == current then
        count = count + 1
      else
        coded   = coded .. get_code(count, current)
        current = c
        count   = 1
      end
    end

    return coded .. get_code(count, current)
  end,
  decode = function(s)
    local plain  = ""
    local digits = ""
    local count  = 0

    for i = 1, #s do
      local c = s:sub(i, i)
      if c:match("%d") then
        digits = digits .. c
      else
        if digits == "" then count = 1 else count = tonumber(digits) end
        plain  = plain .. c:rep(count)
        digits = ""
      end
    end

    return plain
  end
}
