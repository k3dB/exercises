class Game
  def initialize
    @current_frame = 1
    @frames        = {
      1 => Frame.new,
      2 => Frame.new,
      3 => Frame.new,
      4 => Frame.new,
      5 => Frame.new,
      6 => Frame.new,
      7 => Frame.new,
      8 => Frame.new,
      9 => Frame.new,
      10 => LastFrame.new
    }
  end

  def roll(pins)
    @frame = @frames[@current_frame]

    @frame.add_roll(pins)
    2.downto(1) { |n| apply_extras_to_prior_frames(n, pins) }
    @current_frame += 1 if advance_frame?

    raise BowlingError.new "Invalid roll." if !valid?(pins)
  end

  def score
    raise BowlingError.new "Cannot score an incomplete game." if !complete_game?
    @frames.values.map(&:score).sum
  end

  private

  def valid?(pins)
    valid_pin_count?(pins) && @frame.valid?
  end

  def valid_pin_count?(pins)
    pins >= 0 && pins <= 10
  end

  def apply_extras_to_prior_frames(num, pins)
    return if @current_frame <= num

    prior_frame = @frames[@current_frame - num]
    prior_frame.apply_extra(pins) if prior_frame.extras?
  end

  def last_frame?
    @current_frame == 10
  end

  def advance_frame?
    !last_frame? && @frame.completed?
  end

  def complete_game?
    last_frame? && @frame.completed?
  end
end

class Game::BowlingError < StandardError
end
