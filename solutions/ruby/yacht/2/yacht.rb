class Yacht
  attr_reader :score

  def initialize(rolls, category)
    @score = 0

    case category
    when 'ones'
      @score = rolls.count(1)
    when 'twos'
      @score = rolls.count(2) * 2
    when 'threes'
      @score = rolls.count(3) * 3
    when 'fours'
      @score = rolls.count(4) * 4
    when 'fives'
      @score = rolls.count(5) * 4
    when 'sixes'
      @score = rolls.count(6) * 6
    when 'full house'
      @score = rolls.sum if full_house?(rolls)
    when 'four of a kind'
      @score = four_of_a_kind(rolls)
    when 'little straight'
      @score = 30 if rolls.sort == [1, 2, 3, 4, 5]
    when 'big straight'
      @score = 30 if rolls.sort == [2, 3, 4, 5, 6]
    when 'choice'
      @score = rolls.sum
    when 'yacht'
      @score = 50 if rolls.all? { |r| r == rolls.first }
    end
  end

  private

  def full_house?(rolls)
    unique_counts = rolls.uniq.map { |r| rolls.count(r) }
    unique_counts.sort == [2, 3]
  end

  def four_of_a_kind(rolls)
    sorted      = rolls.sort
    first_count = rolls.count(sorted.first)
    last_count  = rolls.count(sorted.last)

    return sorted.first * 4 if first_count >= 4
    return sorted.last  * 4 if last_count  >= 4
    return 0
  end
end
