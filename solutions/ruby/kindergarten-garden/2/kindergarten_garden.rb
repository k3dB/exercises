class Garden
  ROW_COUNT     = 2
  ROW_SEPARATOR = "\n"

  PLANT_CODES = {
    "G": :grass,
    "C": :clover,
    "R": :radishes,
    "V": :violets
  }.freeze

  STUDENTS = %w(
    alice
    bob
    charlie
    david
    eve
    fred
    ginny
    harriet
    ileana
    joseph
    kincaid
    larry
  ).freeze

  def initialize(diagram, students = STUDENTS)
    @window_rows = diagram.split(ROW_SEPARATOR)

    students.map(&:downcase).sort.each_with_index do |student, index|
      define_singleton_method(student) do
        plants(ROW_COUNT * index)
      end
    end
  end

  private

  def plants(start)
    codes     = []
    locations = (0...ROW_COUNT).map { |i| start + i }

    @window_rows.each do |row|
      locations.each { |i| codes << row.chars[i] }
    end

    codes.map { |c| PLANT_CODES.fetch(c.to_sym) }
  end
end
