class AssemblyLine
  PRODUCTION_RATE  = 221
  MINUTES_PER_HOUR = 60

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    @speed * PRODUCTION_RATE * success_rate
  end

  def working_items_per_minute
    (production_rate_per_hour / MINUTES_PER_HOUR).floor
  end

  private

  def success_rate
    case @speed
      when 1..4
        1.00
      when 5..8
        0.90
      when 9
        0.80
      else
        0.77
    end
  end
end
