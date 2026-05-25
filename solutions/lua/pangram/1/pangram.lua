return function(text)
  local letters = {
    ["A"] = 0,
    ["B"] = 0,
    ["C"] = 0,
    ["D"] = 0,
    ["E"] = 0,
    ["F"] = 0,
    ["G"] = 0,
    ["H"] = 0,
    ["I"] = 0,
    ["J"] = 0,
    ["K"] = 0,
    ["L"] = 0,
    ["M"] = 0,
    ["N"] = 0,
    ["O"] = 0,
    ["P"] = 0,
    ["Q"] = 0,
    ["R"] = 0,
    ["S"] = 0,
    ["T"] = 0,
    ["U"] = 0,
    ["V"] = 0,
    ["W"] = 0,
    ["X"] = 0,
    ["Y"] = 0,
    ["Z"] = 0
  }

  local uppercase_text = string.upper(text)

  for i = 1, #uppercase_text do
    local character = string.sub(uppercase_text, i, i)

    if string.match(character, "%a") then
      letters[character] = letters[character] + 1
    end
  end

  for k, v in pairs(letters) do
    if v == 0 then return false end
  end

  return true
end
