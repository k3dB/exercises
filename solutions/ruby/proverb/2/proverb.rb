class Proverb
  def initialize(*items, qualifier: "")
    @items = items
    @qualifier = qualifier + " " unless qualifier.empty?
  end

  def to_s
    lines = @items.each_cons(2).map do |wanted_item, lost_item|
      "For want of a #{wanted_item} the #{lost_item} was lost."
    end

    lines << "And all for the want of a #{@qualifier}#{@items.first}."
    lines.join("\n")
  end
end
