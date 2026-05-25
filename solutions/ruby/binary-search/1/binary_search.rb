class BinarySearch
  def initialize(items)
    @items = items
  end

  def search_for(item)
    # @items.index(item)

    lower_bound = 0
    upper_bound = @items.size - 1

    while lower_bound <= upper_bound
      midpoint = (lower_bound + upper_bound) / 2
      middle_value = @items[midpoint]

      return midpoint if item == middle_value

      if item < middle_value
        upper_bound = midpoint - 1
      else
        lower_bound = midpoint + 1
      end
    end

    nil
  end
end
