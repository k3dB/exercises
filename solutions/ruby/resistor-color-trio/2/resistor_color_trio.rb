class ResistorColorTrio
  PREFIX = "Resistor value: "
  SUFFIX = "ohms"
  KILO   = "kilo"
  CODES  = %w[black brown red orange yellow green blue violet grey white].freeze

  attr_reader :colors

  def initialize(colors)
    @colors = colors
  end

  def label
    raise ArgumentError unless valid?
    PREFIX + value + SUFFIX
  end

  private

  def valid?
    colors.size == 3 && colors.all? { |c| CODES.include?(c) }
  end

  def value
    amount = numeric_value
    amount >= 1000 ? text(amount / 1000) + KILO : text(amount)
  end

  def numeric_value
    (digit(0) * 10 + digit(1)) * 10**digit(2)
  end

  def digit(index)
    CODES.index(colors[index])
  end

  def text(amount)
    amount.to_s + " "
  end
end
