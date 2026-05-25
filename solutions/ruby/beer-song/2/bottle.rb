class BottlesFactory
  attr_reader :create_bottles

  def initialize(count)
    case count
    when 1
      @create_bottles = BottlesSingle.new(count)
    when 0
      @create_bottles = BottlesEmpty.new(count)
    else
      @create_bottles = BottlesMultiple.new(count)
    end
  end
end

class BottlesMultiple
  attr_reader :count, :max

  def initialize(count, max = 99)
    @count = count
    @max   = max.to_s
  end

  def starting_amount
    amount << bottles_text(count)
  end

  def amount_left
    (count - 1).to_s << bottles_text(count - 1)
  end

  def action
    "Take one down and pass it around"
  end

  private

  def amount
    count.to_s
  end

  def bottles_text(amount)
    amount != 1 ? " bottles" : " bottle"
  end
end

class BottlesSingle < BottlesMultiple
  def amount_left
    "no more bottles"
  end

  def action
    "Take it down and pass it around"
  end
end

class BottlesEmpty < BottlesMultiple
  def amount_left
    "#{max} bottles"
  end

  def action
    "Go to the store and buy some more"
  end

  private

  def amount
    "no more"
  end
end
