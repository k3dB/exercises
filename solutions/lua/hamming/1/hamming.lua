local Hamming = {}

local function has_same_length(a, b)
  return string.len(a) == string.len(b)
end

local function get_nucleotide(strand, i)
  return string.upper(string.sub(strand, i, i))
end

function Hamming.compute(a, b)
  if not has_same_length(a, b) then
    return -1
  end

  diff_count = 0

  for i = 1, string.len(a) do
    if get_nucleotide(a, i) ~= get_nucleotide(b, i) then
      diff_count = diff_count + 1
    end
  end

  return diff_count
end

return Hamming
