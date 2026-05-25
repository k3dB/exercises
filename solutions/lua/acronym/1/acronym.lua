return function(text)
  local filteredText = text:gsub("[^%a%-%s]", "")

  filteredText = filteredText:gsub("(%l)(%u)", "%1 %2")

  local acronym = filteredText:gsub("(%a+)",
    function(match) return match:sub(1, 1) end)

  return string.upper(acronym:gsub(" ", ""))
end
