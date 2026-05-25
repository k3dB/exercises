class School
  attr_reader :roster

  def initialize
    @roster = []
  end

  def students(grade)
    roster
      .select { |s| s.grade == grade }
      .map    { |s| s.name }
      .sort
  end

  def add(name, grade)
    roster << Student.new(name, grade)
  end

  def students_by_grade
    roster
      .map(&:grade).uniq.sort
      .map do |g|
        { grade: g, students: students(g) }
      end
  end

  private

  Student = Struct.new(:name, :grade)
end
