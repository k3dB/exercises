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
      10 => Frame.new
    }
  end

  def roll(pins)
    @pins  = pins
    @frame = @frames[@current_frame]

    @frame.add_roll(pins)
    2.downto(1) { |n| apply_extras_to_prior_frames(n) }
    @current_frame += 1 if advance_frame?

    raise BowlingError.new "Invalid roll." if !valid_roll?
  end

  def score
    raise BowlingError.new "Cannot score an incomplete game." if !complete_game?
    @frames.values.map(&:score).sum
  end

  private

  attr_reader :pins

  def valid_roll?
    RollValidator.new(@frame, pins, last_frame?).valid?
  end

  def apply_extras_to_prior_frames(num)
    return if !prior_frame?(num)

    prior_frame = @frames[@current_frame - num]
    prior_frame.apply_extra(pins) if prior_frame.extras?
  end

  def prior_frame?(num)
    @current_frame > num
  end

  def advance_frame?
    !last_frame? && (@frame.strike? || @frame.rolls.size == 2)
  end

  def last_frame?
    @current_frame == 10
  end

  def complete_game?
    last_frame? && last_frame_completed?
  end

  def last_frame_completed?
    size = @frame.rolls.size
    size == 2 && @frame.score < 10 || size == 3
  end
end

class Game::BowlingError < StandardError
end
