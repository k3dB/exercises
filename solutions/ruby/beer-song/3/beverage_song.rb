require_relative 'beverage_verse'

class BeverageSong
  class << self
    attr_accessor :remaining_count

    VERSE_SEPARATOR = "\n"

    def recite(bottle_count, verse_count)
      @remaining_count = bottle_count
      verses           = BeverageVerse.new(self).to_s

      (verse_count - 1).times do
        @remaining_count -= 1
        verses << VERSE_SEPARATOR
        verses << BeverageVerse.new(self).to_s
      end

      verses
    end

    def beverage
      "wine"
    end

    def location
      "in the cellar"
    end

    def max
      99
    end
  end
end
