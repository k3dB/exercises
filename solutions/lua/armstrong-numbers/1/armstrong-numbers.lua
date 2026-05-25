local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
  digits = tostring(number)
  exponent = #digits
  sum = 0

  digits:gsub(".", function (digit)
    sum = sum + tonumber(digit)^exponent
  end)

  return number == sum
end

return ArmstrongNumbers
