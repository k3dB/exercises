class LastFrame < Frame
  def completed?
    size == 2 && score < 10 || size == 3
  end

  def valid?
    valid_roll_total? && valid_extra_roll?
  end

  private

  def valid_roll_total?
    total <= 10 && size <= 2 || total > 10 && size <= 3
  end

  def valid_extra_roll?
    first  = size > 0 ? rolls[0] : 0
    second = size > 1 ? rolls[1] : 0

    size < 3 || first < 10 || second >= 10 || total <= 20
  end
end
