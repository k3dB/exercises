class Proverb
  def initialize(*items, qualifier: "")
    @items = items
    @qualifier = qualifier + " " unless qualifier.empty?
  end

  def to_s
    proverb = ""

    (1..@items.size - 1).each do |i|
      proverb << "For want of a #{@items[i - 1]} the #{@items[i]} was lost.\n"
    end

    proverb << "And all for the want of a #{@qualifier}#{@items.first}."
  end
end
