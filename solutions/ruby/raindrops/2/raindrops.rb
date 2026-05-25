class Raindrops

  def self.convert(number)
    words = get_words(number)
    words.empty? ? number.to_s : words
  end

  private

  def self.get_words(number)
    words = ""
    words << "Pling" if number % 3 == 0
    words << "Plang" if number % 5 == 0
    words << "Plong" if number % 7 == 0
    words
  end

end
