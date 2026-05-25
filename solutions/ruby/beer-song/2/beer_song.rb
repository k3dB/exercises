require_relative 'beverage_song'

class BeerSong < BeverageSong
  class << self
    def beverage
      "beer"
    end

    def location
      "on the wall"
    end
  end
end
