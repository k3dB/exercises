class ResistorColorDuo
  TENS_VALUE = 0
  ONES_VALUE = 1

  VALUES = [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
  ].freeze

  def self.value(colors)
    calculate_value(
      color_value(colors[TENS_VALUE]),
      color_value(colors[ONES_VALUE]))
  end

  private

  def self.color_value(color)
    VALUES.index(color) || 0
  end

  def self.calculate_value(tens, ones)
    tens * 10 + ones
  end

end
