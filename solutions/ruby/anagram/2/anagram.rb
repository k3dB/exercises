class Anagram
  def initialize(word)
    @word        = word
    @sorted_word = sort(word)
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
    sort(candidate) == sorted_word
  end

  def sort(text)
    text.upcase.chars.sort.join
  end
end
