class Series
  def initialize(digits)
    @digits = digits.chars.map do |d|
      raise ArgumentError unless d.match?(/\d/)
      d.to_i
    end
  end

  def largest_product(span)
    raise ArgumentError if span > @digits.length
    product = 0

    @digits.each_cons(span) do |s|
      current = s.reduce(1, :*)
      product = current if current > product
    end

    product
  end
end
