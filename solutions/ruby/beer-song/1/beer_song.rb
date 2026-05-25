class BeerSong
  VERSE_SEPARATOR = "\n"

  def self.recite(initial_bottle_count, verse_count)
    verses       = Verse.new(initial_bottle_count).to_s
    bottle_count = initial_bottle_count

    (verse_count - 1).times do
      bottle_count -= 1
      verses << VERSE_SEPARATOR
      verses << Verse.new(bottle_count).to_s
    end

    verses
  end
end

class Verse
  attr_reader :bottles

  def initialize(bottle_count)
    @bottles = BottlesFactory.new(bottle_count).create_bottles
  end

  def to_s
    verse = "%s of beer on the wall, %s of beer.\n" \
      % [bottles.starting_amount.capitalize, bottles.starting_amount]

    verse << "%s, %s of beer on the wall.\n" \
      % [bottles.action, bottles.amount_left]

    verse
  end
end

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
  attr_reader :count

  def initialize(count)
    @count = count
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
    "99 bottles"
  end

  def action
    "Go to the store and buy some more"
  end

  private

  def amount
    "no more"
  end
end
