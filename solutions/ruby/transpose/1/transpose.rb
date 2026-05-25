class Transpose
  FILLER = "•"

  def self.transpose(input)
    return input if input.empty?

    initial_rows = input.split("\n")
    max_length   = initial_rows.max_by(&:length).length

    initial_rows
      .map { |r| r.ljust(max_length, FILLER).chars }
      .transpose
      .map { |r| clean(r.join) }
      .join("\n")
      .gsub(FILLER, " ")
  end

  private

  def self.clean(row)
    row = row.delete_suffix(FILLER) while row.end_with?(FILLER)
    row
  end
end
