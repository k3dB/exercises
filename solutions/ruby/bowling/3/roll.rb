class Roll
  attr_reader :pins

  def initialize(pins)
    @pins = pins
  end

  def valid?
    valid_pin_count?
  end

  private

  def valid_pin_count?
    pins >= 0 && pins <= 10
  end
end
