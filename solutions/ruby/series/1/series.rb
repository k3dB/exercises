class Series

  attr_reader :digits

  def initialize(text)
    @digits = text.split('')
  end

  def slices(size)
    raise ArgumentError.new(
      "Expected a value of 1-#{digits.size}, but got #{size}."
    ) if size > digits.size

    digits
      .each_index
      .map { |i| digits.drop(i).take(size).join }
      .select { |x| x.length == size }
  end

end
