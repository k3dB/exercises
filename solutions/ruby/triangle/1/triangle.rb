class Triangle
  def initialize(sides)
    @sides = sides
    @min   = sides.min
    @mid   = sides.sort[1]
    @max   = sides.max
  end

  def equilateral?
    valid? && min == max
  end

  def isosceles?
    valid? && (mid == min || mid == max)
  end

  def scalene?
    valid? && !isosceles?
  end

  private

  attr_reader :sides, :min, :mid, :max

  def valid?
    min + mid > max
  end
end
