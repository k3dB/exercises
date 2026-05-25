class Phrase

  attr_reader :words

  def initialize(phrase)
    @words = parse(phrase)
  end

  def word_count
    words
      .map { |w| [w, words.count(w)] }
      .to_h
  end

  private

  def parse(phrase)
    phrase
      .scan(/\b[\w']+\b/)
      .map(&:downcase)
  end

end
