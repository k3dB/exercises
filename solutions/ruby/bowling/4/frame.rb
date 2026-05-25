class Frame
  attr_reader :rolls, :score, :extras

  def initialize
    @rolls  = []
    @score  = 0
    @extras = 0
  end

  def add_roll(pins)
    @rolls << pins
    add_score(pins)
    @extras = 2 if strike?
    @extras = 1 if spare?
  end

  def apply_extra(pins)
    add_score(pins)
    @extras -= 1
  end

  def strike?
    size == 1 && all_pins?
  end

  def spare?
    size == 2 && all_pins?
  end

  def extras?
    extras > 0
  end

  def completed?
    strike? || size == 2
  end

  def valid?
    total <= 10 && size <= 2
  end

  private

  def add_score(pins)
    @score += pins
  end

  def total
    rolls.sum
  end

  def size
    rolls.size
  end

  def all_pins?
    score == 10
  end
end
