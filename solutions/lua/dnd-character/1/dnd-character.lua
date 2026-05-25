local Character = {}

local function ability(scores)
  local total = 0
  local lowest = scores[1]

  for i = 1, 4 do
    if lowest > scores[i] then lowest = scores[i] end
    total = total + scores[i]
  end

  return total - lowest
end

local function roll_dice()
  local values = {}
  math.randomseed(math.floor(os.clock() * 100000000000))

  for i = 1, 4 do
    table.insert(values, i, math.random(6))
  end

  return values
end

local function modifier(input)
  return math.floor((input - 10) / 2)
end

function Character:new(name)
  local character = setmetatable({}, self)
  self.__index = self

  character.name         = name
  character.strength     = ability(roll_dice())
  character.dexterity    = ability(roll_dice())
  character.constitution = ability(roll_dice())
  character.intelligence = ability(roll_dice())
  character.wisdom       = ability(roll_dice())
  character.charisma     = ability(roll_dice())
  character.hitpoints    = 10 + modifier(character.constitution)

  return character
end

return {
  Character = Character,
  ability   = ability,
  roll_dice = roll_dice,
  modifier  = modifier
}
