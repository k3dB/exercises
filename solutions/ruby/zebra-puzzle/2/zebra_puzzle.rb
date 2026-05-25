class ZebraPuzzle
  class << self
    def water_drinker
      houses.find { |h| h[:beverages].first == 'water' }[:nationalities].first
    end

    def zebra_owner
      houses.find { |h| h[:pets].first == 'zebra' }[:nationalities].first
    end

    private

    def houses
      ZebraPuzzleSolver.new.solve
    end
  end
end

class ZebraPuzzleSolver
  def initialize
    # Using the newer format with hobbies.
    # Ruby track is not yet using this at the time of writing this, but the
    # tests only care about nationalities, beverages, and pets.
    # Therefore, the other attributes can be arbitrarily substituted
    # so long as the rules stay consistent with the intended solution.
    house = {
      :colors        => ['red', 'ivory', 'green', 'yellow', 'blue'],
      :nationalities => ['Englishman', 'Spaniard', 'Ukrainian', 'Japanese', 'Norwegian'],
      :pets          => ['dog', 'snail', 'fox', 'horse', 'zebra'],
      :beverages     => ['coffee', 'tea', 'milk', 'orange juice', 'water'],
      :hobbies       => ['dancing', 'painting', 'reading', 'football', 'chess']
    }

    @houses      = []
    @updated     = true
    @valid_trial = true

    # Need a deep copy because we are using "process of elimination" to solve.
    (0..4).each { |i| @houses[i] = Marshal.load(Marshal.dump(house)) }
  end

  def solve
    # Known "knowns"
    known(@houses, 2, :beverages, 'milk')
    known(@houses, 0, :nationalities, 'Norwegian')
    known(@houses, 1, :colors, 'blue')

    # Eliminate as much as possible by applying each rule one at a time.
    run_rules_until_nothing_is_removed(@houses)

    # Brute force the rest by trying each possibility left.
    trial_and_error(@houses)

    @houses
  end

  private

  def known(houses, index, key, value)
    houses[index][key] = [value]

    houses.each_index do |i|
      remove!(houses, i, key, value) unless i == index
    end
  end

  def remove!(houses, index, key, value)
    return unless houses[index][key].include?(value)
    position = houses[index][key].index(value)
    houses[index][key].slice!(position)
    @updated = true
    @valid_trial = false if houses[index][key].empty?
  end

  def run_rules_until_nothing_is_removed(houses)
    @updated = true
    while @updated
      @updated = false
      run_rules(houses)
    end
  end

  def run_rules(houses)
    houses.each_index do |i|
      same(houses, i, :nationalities, 'Englishman', :colors, 'red')
      same(houses, i, :nationalities, 'Spaniard', :pets, 'dog')
      same(houses, i, :colors, 'green', :beverages, 'coffee')
      same(houses, i, :nationalities, 'Ukrainian', :beverages, 'tea')
      left_right(houses, i, :colors, 'ivory', :colors, 'green')
      same(houses, i, :pets, 'snail', :hobbies, 'dancing')
      same(houses, i, :colors, 'yellow', :hobbies, 'painting')
      next_to(houses, i, :hobbies, 'reading', :pets, 'fox')
      next_to(houses, i, :hobbies, 'painting', :pets, 'horse')
      same(houses, i, :hobbies, 'football', :beverages, 'orange juice')
      same(houses, i, :nationalities, 'Japanese', :hobbies, 'chess')
    end

    houses.each_index do |indexToRemove|
      houses.each_index do |indexToCheck|
        next if indexToCheck == indexToRemove
        check_solved(houses, indexToCheck, :colors,        indexToRemove)
        check_solved(houses, indexToCheck, :nationalities, indexToRemove)
        check_solved(houses, indexToCheck, :pets,          indexToRemove)
        check_solved(houses, indexToCheck, :beverages,     indexToRemove)
        check_solved(houses, indexToCheck, :hobbies,       indexToRemove)
      end
    end
  end

  def check_solved(houses, indexToCheck, key, indexToRemove)
    return unless solved?(houses, indexToCheck, key)
    remove!(houses, indexToRemove, key, houses[indexToCheck][key].first)
  end

  def solved?(houses, index, key)
    houses[index][key].length == 1
  end

  def same(houses, index, key_1, value_1, key_2, value_2)
    if !houses[index][key_1].include?(value_1)
      remove!(houses, index, key_2, value_2)
    end

    if !houses[index][key_2].include?(value_2)
      remove!(houses, index, key_1, value_1)
    end

    if solution?(houses, index, key_1, value_1)
      known(houses, index, key_2, value_2)
    end

    if solution?(houses, index, key_2, value_2)
      known(houses, index, key_1, value_1)
    end
  end

  def solution?(houses, index, key, value)
    houses[index][key].length == 1 && houses[index][key].first == value
  end

  def left_right(houses, index, left_key, left_value, right_key, right_value)
    remove!(houses, 0, right_key, right_value)
    remove!(houses, 4, left_key,  left_value )

    if index < 4
      if !houses[index][left_key].include?(left_value)
        remove!(houses, index + 1, right_key, right_value)
      end

      if solution?(houses, index, left_key, left_value)
        known(houses, index + 1, right_key, right_value)
      end

      if solution?(houses, index + 1, right_key, right_value)
        known(houses, index, left_key, left_value)
      end
    end

    if index > 0
      if !houses[index][right_key].include?(right_value)
        remove!(houses, index - 1, left_key, left_value)
      end

      if solution?(houses, index, right_key, right_value)
        known(houses, index - 1, left_key, left_value)
      end

      if solution?(houses, index - 1, left_key, left_value)
        known(houses, index, right_key, right_value)
      end
    end
  end

  def next_to(houses, index, key_1, value_1, key_2, value_2)
    if solution?(houses, index, key_1, value_1)
      known(houses, index + 1, key_2, value_2) if index.zero?
      known(houses, index - 1, key_2, value_2) if index == 4
      remove!(houses, index, key_2, value_2)
      (index + 2).upto(4)   { |i| remove!(houses, i, key_2, value_2) }
      (index - 2).downto(0) { |i| remove!(houses, i, key_2, value_2) }
    end

    if solution?(houses, index, key_2, value_2)
      known(houses, index + 1, key_1, value_1) if index.zero?
      known(houses, index - 1, key_1, value_1) if index == 4
      remove!(houses, index, key_1, value_1)
      (index + 2).upto(4)   { |i| remove!(houses, i, key_1, value_1) }
      (index - 2).downto(0) { |i| remove!(houses, i, key_1, value_1) }
    end
  end

  def trial_and_error(houses)
    houses.each_index do |i|
      run_trial(houses, i, :colors)
      run_trial(houses, i, :nationalities)
      run_trial(houses, i, :pets)
      run_trial(houses, i, :beverages)
      run_trial(houses, i, :hobbies)
    end
  end

  def run_trial(houses, index, key)
    return if solved?(houses, index, key)

    trial_houses = Marshal.load(Marshal.dump(houses))
    @valid_trial = true

    houses[index][key].each do |trial|
      known(trial_houses, index, key, trial)
      run_rules_until_nothing_is_removed(trial_houses)
      next if @valid_trial
      remove!(houses, index, key, trial)
      run_rules_until_nothing_is_removed(houses)
    end
  end
end
