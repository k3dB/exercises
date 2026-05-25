class TwoBucket
  BUCKET_ONE = "one"
  BUCKET_TWO = "two"

  attr_reader :moves, :goal_bucket, :other_bucket

  def initialize(small_size, large_size, goal, starting_bucket)
    @moves        = 0
    @goal_bucket  = ""
    @other_bucket = 0 # Amount of non-goal bucket

    starts_with_one = starting_bucket == BUCKET_ONE
    non_starting_bucket = starts_with_one ? BUCKET_TWO : BUCKET_ONE

    first_bucket  = Bucket.new(starts_with_one ? small_size : large_size)
    second_bucket = Bucket.new(starts_with_one ? large_size : small_size)

    while @goal_bucket.empty?
      @moves += 1

      if @moves == 1
        first_bucket.fill # Must fill first bucket on first move
      elsif @moves == 2 && second_bucket.capacity == goal
        second_bucket.fill # Edge case shortcut to reach goal
      elsif @moves.even?
        first_bucket.pour_into(second_bucket)
      elsif second_bucket.full?
        second_bucket.drain
      else
        first_bucket.fill
      end

      @goal_bucket = starting_bucket     if first_bucket.amount  == goal
      @goal_bucket = non_starting_bucket if second_bucket.amount == goal
    end

    @other_bucket = first_bucket.amount  if @goal_bucket == non_starting_bucket
    @other_bucket = second_bucket.amount if @goal_bucket == starting_bucket

  end
end

class Bucket
  attr_reader :capacity, :amount

  def initialize(capacity)
    @capacity = capacity
    @amount   = 0
  end

  def fill(amount = free_amount)
    @amount += amount
  end

  def drain(amount = @amount)
    @amount -= amount
  end

  def pour_into(bucket)
    displacement = @amount >= bucket.free_amount ? bucket.free_amount : @amount

    bucket.fill(displacement)
    drain(displacement)
  end

  def free_amount
    @capacity - @amount
  end

  def full?
    @amount == @capacity
  end
end
