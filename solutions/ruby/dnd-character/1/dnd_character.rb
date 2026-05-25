class DndCharacter
  BASE_HITPOINTS = 10

  def self.modifier(input)
    (input - BASE_HITPOINTS).div(2)
  end

  attr_reader :strength, :dexterity, :constitution, :intelligence
  attr_reader :wisdom, :charisma, :hitpoints

  def initialize
    @strength     = roll_dice
    @dexterity    = roll_dice
    @constitution = roll_dice
    @intelligence = roll_dice
    @wisdom       = roll_dice
    @charisma     = roll_dice
    @hitpoints    = BASE_HITPOINTS + DndCharacter.modifier(@constitution)
  end

  private

  def roll_dice
    rolls = []
    4.times { rolls << Random.rand(6) + 1 }
    rolls.sort.reverse.take(3).sum
  end
end
