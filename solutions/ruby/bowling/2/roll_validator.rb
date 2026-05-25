class RollValidator
  def initialize(frame, pins, last_frame)
    @frame      = frame
    @pins       = pins
    @last_frame = last_frame
    @size       = frame.rolls.size
    @total      = frame.rolls.sum
  end

  def valid?
    valid_pin_count? &&
    valid_frame_score? &&
    valid_second_roll_score? &&
    valid_last_frame?
  end

  private

  attr_reader :frame, :pins, :size, :total

  def last_frame?
    @last_frame
  end

  def valid_pin_count?
    pins >= 0 && pins <= 10
  end

  def valid_frame_score?
    total <= 10 && size <= 2 || last_frame? && total > 10 && size <= 3
  end

  def valid_second_roll_score?
    size != 2 || (last_frame? ? total <= 20 : total <= 10)
  end

  def valid_last_frame?
    first  = size > 0 ? frame.rolls[0] : 0
    second = size > 1 ? frame.rolls[1] : 0

    !last_frame? || size < 3 || first < 10 || second >= 10 || total <= 20
  end
end
