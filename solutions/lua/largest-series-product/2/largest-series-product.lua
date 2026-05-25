return function(config)
  if config.span > #config.digits then
    error("Span cannot be larger than the number of digits.")
  end

  if config.span < 0 then error("Span cannot be negative.") end

  if tonumber(config.digits) == nil then error("Invalid digit.") end

  local product = 0

  for i = 1, #config.digits - config.span + 1 do
    local subset  = config.digits:sub(i, i + config.span - 1)
    local current = 1

    for j = 1, #subset do
      local digit = tonumber(subset:sub(j, j))
      current = current * digit
    end

    if current > product then product = current end
  end

  return product
end
