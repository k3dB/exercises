local Hamming = {}

local function nucleotide(strand, i)
  return string.upper(string.sub(strand, i, i))
end

function Hamming.compute(a, b)
  if #a ~= #b then
    return -1
  end

  distance = 0

  for i = 1, #a do
    if nucleotide(a, i) ~= nucleotide(b, i) then
      distance = distance + 1
    end
  end

  return distance
end

return Hamming
