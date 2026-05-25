class Minesweeper
  class << self
    def annotate(grid)
      grid.each_with_index do |r, i|
        r.chars.each_with_index do |c, j|
          next unless bomb?(c)
          check_row(grid[i - 1], j) unless i.zero?
          check_row(r, j)
          check_row(grid[i + 1], j) if i < grid.length - 1
        end
      end

      grid
    end

    private

    def check_row(row, index)
      if index > 0 then
        row[index - 1] = (row[index - 1].to_i + 1).to_s unless bomb?(row[index - 1])
      end

      row[index] = (row[index].to_i + 1).to_s unless bomb?(row[index])

      if index < row.length - 1 then
        row[index + 1] = (row[index + 1].to_i + 1).to_s unless bomb?(row[index + 1])
      end
    end

    def bomb?(c)
      c == "*"
    end
  end
end
