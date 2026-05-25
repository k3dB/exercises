class ResistorColorDuo
  TENS_INDEX = 0
  ONES_INDEX = 1

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
  ]

  def self.value(colors)
    calculate_value(
      get_color_value(colors[TENS_INDEX]),
      get_color_value(colors[ONES_INDEX]))
  end

  private

  def self.get_color_value(color)
    VALUES.index(color) || 0
  end

  def self.calculate_value(tens, ones)
    tens * 10 + ones
  end
end
