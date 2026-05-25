require_relative 'bottle'

class BeverageVerse
  attr_reader :bottles, :beverage, :location

  def initialize(song)
    @bottles = BottlesFactory
      .new(song.remaining_count, song.max)
      .create_bottles

    @beverage = song.beverage
    @location = song.location
  end

  def to_s
    verse = "%s of %s %s, %s of %s.\n" % [
      bottles.starting_amount.capitalize,
      beverage,
      location,
      bottles.starting_amount,
      beverage
    ]

    verse << "%s, %s of %s %s.\n" % [
      bottles.action,
      bottles.amount_left,
      beverage,
      location
    ]

    verse
  end
end
