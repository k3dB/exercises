class Yacht
  attr_reader :score

  def initialize(rolls, category)
    @score = 0

    case category
    when 'ones'
      @score = rolls.count { |r| r == 1 }
    when 'twos'
      @score = rolls.count { |r| r == 2 } * 2
    when 'threes'
      @score = rolls.count { |r| r == 3 } * 3
    when 'fours'
      @score = rolls.count { |r| r == 4 } * 4
    when 'fives'
      @score = rolls.count { |r| r == 5 } * 4
    when 'sixes'
      @score = rolls.count { |r| r == 6 } * 6
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
    sorted = rolls.sort
    first  = sorted.first
    last   = sorted.last
    match2 = first == sorted[1] && last == sorted[3]
    middle = sorted[2] == first || sorted[2] == last

    first != last && match2 && middle
  end

  def four_of_a_kind(rolls)
    sorted      = rolls.sort
    first_count = rolls.count { |r| r == sorted.first }
    last_count  = rolls.count { |r| r == sorted.last  }

    return sorted.first * 4 if first_count >= 4
    return sorted.last  * 4 if last_count  >= 4

    0
  end
end
