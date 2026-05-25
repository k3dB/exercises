class Allergies
  ALLERGENS = {
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

  def allergic_to?(allergen)
    allergen_mask = ALLERGENS.fetch(allergen.to_sym)
    @score & allergen_mask == allergen_mask
  end

  def list
    ALLERGENS.keys
      .map(&:to_s)
      .select(&method(:allergic_to?))
  end
end
