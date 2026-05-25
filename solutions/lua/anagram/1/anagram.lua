local Anagram = {
  word = ""
}

function Anagram:new(word)
  local anagram = setmetatable({}, self)
  self.__index = self

  anagram.word = word
  return anagram
end

function Anagram:match(candidates)
  local anagrams = {}
  local lower_case_word = self.word:lower()

  for _, v in pairs(candidates) do
    local candidate = v:lower()
    local letter_counts = {}

    for i = 1, #candidate do
      local c = candidate:sub(i, i)
      if letter_counts[c] ~= nil then
        letter_counts[c] = letter_counts[c] + 1
      else
        letter_counts[c] = 1
      end
    end

    for i = 1, #lower_case_word do
      local w = lower_case_word:sub(i, i)
      if letter_counts[w] ~= nil then
        letter_counts[w] = letter_counts[w] - 1
      else
        letter_counts[w] = -1
      end
    end

    local is_anagram = candidate ~= lower_case_word

    for _, count in pairs(letter_counts) do
      if count ~= 0 then is_anagram = false end
    end

    if is_anagram then table.insert(anagrams, v) end
  end

  return anagrams
end

return Anagram
