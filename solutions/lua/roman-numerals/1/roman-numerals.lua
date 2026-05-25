return {
  to_roman = function(n)
    local numerals = {
      [1000] = "M", [900] = "CM",
      [ 500] = "D", [400] = "CD",
      [ 100] = "C", [ 90] = "XC",
      [  50] = "L", [ 40] = "XL",
      [  10] = "X", [  9] = "IX",
      [   5] = "V", [  4] = "IV",
      [   1] = "I"
    }

    -- Sort by key (descending) for calculations
    local keys = {}

    for k, _ in pairs(numerals) do
      table.insert(keys, k)
    end

    table.sort(keys, function(a, b) return a > b end)

    -- Build roman numeral
    local roman = ""

    for i = 1, #keys do
      local key   = keys[i]
      local count = n // key

      for j = 1, count do
        roman = roman .. numerals[key]
      end

      n = n % key
    end

    return roman
  end
}
