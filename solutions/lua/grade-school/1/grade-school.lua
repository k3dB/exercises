local School = {}

local roster = {}

function School:new()
  setmetatable({}, self)
  roster = {}
  return self
end

function School:roster()
  return roster
end

function School:add(name, grade)
  if roster[grade] == nil then
    roster[grade] = { name }
  else
    table.insert(roster[grade], name)
  end

  table.sort(roster[grade])
end

function School:grade(grade)
  if roster[grade] == nil then return {} end
  return roster[grade]
end

return School
