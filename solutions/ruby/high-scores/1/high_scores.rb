class HighScores

  def initialize(scores)
    @scores = scores
  end

  def scores
    @scores
  end

  def latest
    @scores.last
  end

  def personal_best
    @scores.max
  end

  def personal_top_three
    personal_top(3)
  end

  def latest_is_personal_best?
    personal_best == latest
  end

  private

  def personal_top(count)
    @scores.sort.reverse.take(count)
  end

end
