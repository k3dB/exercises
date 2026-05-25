class Grid
  def self.saddle_points(rows)
    columns = rows.transpose

    points = []

    rows.each_with_index do |r, ri|
      columns.each_with_index do |c, ci|
        points << { "row" => ri + 1, "column" => ci + 1 } if r.max == c.min
      end
    end

    points
  end
end
