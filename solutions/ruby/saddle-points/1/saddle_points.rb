class Matrix
  attr_reader :rows, :columns

  def initialize(matrix)
    @rows = matrix
      .split("\n")
      .map { |r| r.split.map(&:to_i) }

    @columns = @rows.transpose
  end

  def saddle_points
    points         = []
    max_per_row    = rows   .map(&:max)
    min_per_column = columns.map(&:min)

    rows.each_with_index do |r, ri|
      columns.each_with_index do |c, ci|
        points << [ri, ci] if max_per_row[ri] == min_per_column[ci]
      end
    end

    points
  end
end
