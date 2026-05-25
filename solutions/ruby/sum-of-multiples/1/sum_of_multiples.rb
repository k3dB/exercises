class SumOfMultiples
  def initialize(*args)
    @multiples = []
    args.sort.each { |a| @multiples << a }
    @min = @multiples.first
  end

  def to(max)
    return 0 if invalid_range?(max)
    (@min...max).reduce { |memo, n| memo + number_to_tally(n) }
  end

  private

  def invalid_range?(max)
    @min.nil? || @min.zero? || @min > max
  end

  def number_to_tally(n)
    multiple?(n) ? n : 0
  end

  def multiple?(n)
    @multiples.any? { |m| n % m == 0 }
  end
end
