class Triangle
  def initialize(number_of_rows)
    @number_of_rows = number_of_rows
  end

  def rows
    triangle = [[]]

    (1..@number_of_rows).each do |n|
      previous = triangle[n - 2] if n > 1
      (0..(n - 1)).each do |i|
        triangle[n - 1] = [1] if i.zero?
        triangle[n - 1] << 1  if i + 1 == n && n > 1
        next if i.zero? || i + 1 == n

        triangle[n - 1] << (previous[i - 1] + previous[i])
      end
    end

    triangle
  end
end
