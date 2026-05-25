class Robot
  attr_reader :name

  FIRST_NAME = "AA000"
  LAST_NAME  = "ZZ999"

  @@random_names = []

  def self.forget
    @@random_names = (FIRST_NAME..LAST_NAME).to_a.shuffle
  end

  def initialize
    reset
  end

  def reset
    old_name = @name
    @name = @@random_names.pop
    @@random_names.unshift(old_name) if old_name
  end
end
