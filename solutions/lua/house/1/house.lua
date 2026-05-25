local house = {}

local beginning = "This is the %s"
local continuation = "that %s the %s"
local newline = "\n"
local ending = "."
local verb_position = 1
local noun_position = 2

local data = {
  { "lay in", "house that Jack built" },
  { "ate", "malt" },
  { "killed", "rat" },
  { "worried", "cat" },
  { "tossed", "dog" },
  { "milked", "cow with the crumpled horn" },
  { "kissed", "maiden all forlorn" },
  { "married", "man all tattered and torn" },
  { "woke", "priest all shaven and shorn" },
  { "kept", "rooster that crowed in the morn" },
  { "belonged to", "farmer sowing his corn" },
  { "", "horse and the hound and the horn" }
}

house.verse = function(which)
  local verb = data[which][verb_position]
  local noun = data[which][noun_position]
  local verse = string.format(beginning, noun)

  while which > 1 do
    which = which - 1
    verb = data[which][verb_position]
    noun = data[which][noun_position]
    verse = verse .. newline .. string.format(continuation, verb, noun)
  end

  return verse .. ending
end

house.recite = function()
  local rhyme = house.verse(1)

  for i = 2, #data do
    rhyme = rhyme .. newline .. house.verse(i)
  end

  return rhyme
end

return house
