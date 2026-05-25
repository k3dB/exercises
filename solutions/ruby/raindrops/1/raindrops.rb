class Raindrops

  def self.convert(number)
    words = get_words(number)
    words.empty? ? number.to_s : words
  end

  private

  def self.get_words(number)
    pling = is_pling?(number) ? "Pling" : ""
    plang = is_plang?(number) ? "Plang" : ""
    plong = is_plong?(number) ? "Plong" : ""

    pling << plang << plong
  end

  def self.is_pling?(number)
    number % 3 == 0
  end

  def self.is_plang?(number)
    number % 5 == 0
  end

  def self.is_plong?(number)
    number % 7 == 0
  end

end
