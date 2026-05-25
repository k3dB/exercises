return function(dna)
  local transcriptions = {
    ["G"] = "C",
    ["C"] = "G",
    ["T"] = "A",
    ["A"] = "U"
  }

  local transcribed = ""

  for i = 1, #dna do
    local nucleotide = dna:sub(i, i)
    transcribed = transcribed .. transcriptions[nucleotide]
  end

  return transcribed
end
