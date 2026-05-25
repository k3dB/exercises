class Anagram
  def initialize(word)
    @word        = word
    @sorted_word = word.upcase.chars.sort.join
  end

  def match(candidates)
    candidates.select { |c| !same_word?(c) && anagram?(c) }
  end

  private

  attr_reader :word, :sorted_word

  def same_word?(candidate)
    candidate.casecmp?(word)
  end

  def anagram?(candidate)
    candidate.upcase.chars.sort.join == sorted_word
  end
end
