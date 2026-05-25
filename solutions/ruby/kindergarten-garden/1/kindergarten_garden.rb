class Garden
  ROW_COUNT     = 2
  ROW_SEPARATOR = "\n"

  PLANT_CODES = {
    "G": "grass",
    "C": "clover",
    "R": "radishes",
    "V": "violets"
  }.freeze

  STUDENTS = [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ].freeze

  def initialize(diagram)
    @window_rows = diagram.split(ROW_SEPARATOR)
  end

  def method_missing(m, *args, &block)
    plants(ROW_COUNT * STUDENTS.index(m.to_sym))
  end

  private

  def plants(start)
    codes     = []
    locations = (0...ROW_COUNT).map { |i| start + i }

    @window_rows.each do |row|
      locations.each { |i| codes << row.chars[i] }
    end

    codes.map { |c| PLANT_CODES.fetch(c.to_sym).to_sym }
  end
end
