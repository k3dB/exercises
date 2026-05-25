local function first_vowel_location(word)
  local first    = #word
  local vowels   = "aeiou"
  local location = 1

  for i = 1, #vowels do
    local vowel = vowels:sub(i, i)
    location = word:find(vowel)
    if location ~= nil and location < first then first = location end
  end

  return first
end

local function moved_consonants(word)
  local vowel_location   = first_vowel_location(word)
  local first_consonants = word:sub(1, vowel_location - 1)

  local last  = first_consonants:sub(#first_consonants, #first_consonants)
  local vowel = word:sub(vowel_location, vowel_location)

  if last == "q" and vowel == "u" then
    return first_consonants .. "u"
  end

  local y_location = first_consonants:find("y")

  if y_location ~= nil and y_location > 1 then
    return first_consonants:sub(1, y_location - 1)
  end

  return first_consonants
end

local function pig_latin_word(word)
  if first_vowel_location(word) == 1 or word:find("xr") == 1 or word:find("yt") == 1 then
    return word .. "ay"
  end

  local moved = moved_consonants(word)
  return word:sub(#moved + 1) .. moved .. "ay"
end

return function(phrase)
  local pig_latin_phrase = ""

  for word in phrase:gmatch("%S+") do
    pig_latin_phrase = pig_latin_phrase .. " " .. pig_latin_word(word)
  end

  return pig_latin_phrase:sub(2)
end
