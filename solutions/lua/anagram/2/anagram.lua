local Anagram = {
  word = ""
}

local function count_letters(counts, word, direction)
    for i = 1, #word do
      local letter = word:sub(i, i)
      if counts[letter] ~= nil then
        counts[letter] = counts[letter] + direction
      else
        counts[letter] = direction
      end
    end

    return counts
end

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

    letter_counts = count_letters(letter_counts, candidate, 1)
    letter_counts = count_letters(letter_counts, lower_case_word, -1)

    local is_anagram = candidate ~= lower_case_word

    for _, count in pairs(letter_counts) do
      if count ~= 0 then is_anagram = false end
    end

    if is_anagram then table.insert(anagrams, v) end
  end

  return anagrams
end

return Anagram
