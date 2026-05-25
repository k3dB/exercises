class Matrix
  attr_reader :rows, :columns

  def initialize(text)
    @rows    = get_rows(text)
    @columns = @rows.transpose
  end

  private

  def get_rows(text)
    text.each_line.map { |row|
      row.split.map { |x| x.to_i }
    }
  end

end
