class ResistorColorDuo
  CODES = %w[
    black
    brown
    red
    orange
    yellow
    green
    blue
    violet
    grey
    white
  ].freeze

  def self.value(colors)
    digit(colors[0]) * 10 + digit(colors[1])
  end

  private

  def self.digit(color)
    CODES.index(color) || 0
  end
end
