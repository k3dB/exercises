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
    roll   = Roll.new(pins)
    @frame = @frames[@current_frame]

    @frame.add_roll(roll)
    2.downto(1) { |n| apply_extras_to_prior_frames(n, roll) }
    @current_frame += 1 if advance_frame?

    raise BowlingError.new "Invalid roll." if !valid?(roll)
  end

  def score
    raise BowlingError.new "Cannot score an incomplete game." if !complete_game?
    @frames.values.map(&:score).sum
  end

  private

  def valid?(roll)
    roll.valid? && @frame.valid?
  end

  def apply_extras_to_prior_frames(num, roll)
    return if @current_frame <= num

    prior_frame = @frames[@current_frame - num]
    prior_frame.apply_extra(roll) if prior_frame.extras?
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
