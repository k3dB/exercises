class SpiralMatrix
  def initialize(size)
    @size = size
  end

  def matrix
    grid = Array.new(@size) { Array.new(@size) }

    x = 0
    y = 0

    min = 0
    max = @size - 1

    direction = 0

    (1..@size**2).each do |n|
      needs_direction_change = false

      current_x = x
      current_y = y

      while grid[x][y]
        direction += 1 if needs_direction_change
        x = current_x
        y = current_y

        y += 1 if y < max && direction % 4 == 0
        x += 1 if x < max && direction % 4 == 1
        y -= 1 if y > min && direction % 4 == 2
        x -= 1 if x > min && direction % 4 == 3

        needs_direction_change = true
      end

      grid[x][y] = n
    end

    grid
  end
end
