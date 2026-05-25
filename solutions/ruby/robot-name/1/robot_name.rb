class Robot
  attr_reader :name

  ALPHA_COUNT          = 2
  NUMERIC_COUNT        = 3
  NUMERIC_PERMUTATIONS = 10**NUMERIC_COUNT

  @@random_names = []

  def self.forget
    self.populate_names
  end

  def initialize
    reset
  end

  def reset
    @name = @@random_names.pop
  end

  private

  class << self
    def populate_names
      all_names   = []
      start_alpha = ""
      end_alpha   = ""

      ALPHA_COUNT.times { start_alpha << "A" }
      ALPHA_COUNT.times { end_alpha   << "Z" }

      for a in (start_alpha..end_alpha)
        alpha = a.to_s
        for n in (0...NUMERIC_PERMUTATIONS)
          next_name = alpha + n.to_s.rjust(NUMERIC_COUNT, "0")
          all_names << next_name
        end
      end
      @@random_names = all_names.shuffle
    end
  end
end
