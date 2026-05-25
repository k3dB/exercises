class Knapsack
  def initialize(capacity)
    @capacity = capacity
  end

  def max_value(items)
    max_values = Array.new(@capacity + 1, 0)

    items.each do |item|
      @capacity.downto(item.weight) do |weight|
          max_values[weight] = [
            max_values[weight],
            max_values[weight - item.weight] + item.value
          ].max
      end
    end

    max_values[@capacity]
  end
end
