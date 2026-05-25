class Pangram
  CAPITAL_LETTERS = (65..90).to_a

  def self.pangram?(text)
    text
      .upcase
      .bytes
      .uniq
      .sort
      .select { |b| CAPITAL_LETTERS.include?(b) }
      .eql?(CAPITAL_LETTERS)
  end
end
