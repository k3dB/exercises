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
    rolls.size == 1 && rolls.first == 10
  end

  def spare?
    rolls.size == 2 && score == 10
  end

  def extras?
    extras > 0
  end

  private

  def add_score(pins)
    @score += pins
  end
end
