class Allergies
  ITEMS = {
    'eggs':           1,
    'peanuts':        2,
    'shellfish':      4,
    'strawberries':   8,
    'tomatoes':      16,
    'chocolate':     32,
    'pollen':        64,
    'cats':         128
  }.freeze

  def initialize(score)
    @score = score
  end

  def allergic_to?(item)
    item_flag = ITEMS.fetch(item.to_sym)
    @score & item_flag == item_flag
  end

  def list
    ITEMS.keys
      .map(&:to_s)
      .select { |k| allergic_to?(k) }
  end
end
