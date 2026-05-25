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
      .split(/[\.,:\!\?\s+]/)
      .map { |w| w.strip }
      .reject { |w| w.empty? || !w.match(/[\w\']/) }
      .map do |w| w
        .downcase
        .delete_prefix("'")
        .delete_suffix("'")
      end
  end

end
