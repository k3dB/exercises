class Matrix
  attr_reader :rows, :columns

  def initialize(text)
    @rows    = get_rows(text)
    @columns = get_columns
  end

  private

  def get_rows(text)
    rows = Array.new

    text.lines.each do |r|
      row = r.delete_prefix('\n').split(' ')
      rows.push(row.map { |x| x.to_i })
    end

    rows
  end

  def get_columns
    columns = Array.new
    rows.first.each { |x| columns.push(Array.new) }

    i = 0
    columns.each { |c|
     rows.each { |r| c.push(r[i]) }
     i += 1
    }

    columns
  end

end
