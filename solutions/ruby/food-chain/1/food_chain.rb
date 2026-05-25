class Critter
  attr_reader :name, :aside, :epithet, :article

  def initialize(name, aside, epithet = "", article = "a")
    @name    = name
    @aside   = aside
    @epithet = epithet
    @article = article
  end
end

class Verse
  def initialize(critters, index)
    @critters = critters
    @index    = index
  end

  def incident
    critter = @critters[@index]
    "I know an old lady who swallowed %s %s.\n%s" % [
      critter.article,
      critter.name,
      critter.aside
    ]
  end

  def recap
    (1..@index)
      .reverse_each
      .map { |i| motivation(@critters[i], @critters[i - 1]) }
      .join
  end

  def motivation(predator, prey)
    "She swallowed the %s to catch the %s%s.\n" % [
      predator.name,
      prey.name,
      prey.epithet
    ]
  end

  def tag
    "I don't know why she swallowed the %s. Perhaps she'll die.\n" % [
      @critters.first.name
    ]
  end

  def to_s
    incident + recap + tag
  end
end

class Conclusion < Verse
  def recap
    ""
  end

  def tag
    "She's dead, of course!\n"
  end
end

class FoodChain
  CRITTERS = [
    Critter.new("fly", ""),
    Critter.new(
      "spider",
      "It wriggled and jiggled and tickled inside her.\n",
      " that wriggled and jiggled and tickled inside her"
    ),
    Critter.new("bird", "How absurd to swallow a bird!\n"),
    Critter.new("cat",  "Imagine that, to swallow a cat!\n"),
    Critter.new("dog",  "What a hog, to swallow a dog!\n"),
    Critter.new("goat", "Just opened her throat and swallowed a goat!\n"),
    Critter.new("cow",  "I don't know how she swallowed a cow!\n"),
    Critter.new("horse", "")
  ]

  def self.song(critters = CRITTERS)
    @critters = critters
    (verses << conclusion).join("\n")
  end

  private

  def self.verses
    (0..@critters.length - 2).map { |i| Verse.new(@critters, i) }
  end

  def self.conclusion
    Conclusion.new(@critters, @critters.length - 1)
  end
end
