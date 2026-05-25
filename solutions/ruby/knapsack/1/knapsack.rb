class Knapsack
  def initialize(capacity)
    @capacity = capacity
  end

  def max_value(items)
    max_values = Array.new(items.length + 1) { Array.new(@capacity + 1, 0) }

    (1..items.length).each do |i|
      (1..@capacity).each do |j|
        if items[i - 1].weight > j then
          max_values[i][j] = max_values[i - 1][j]
        else
          max_values[i][j] = [
            max_values[i - 1][j],
            max_values[i - 1][j - items[i - 1].weight] + items[i - 1].value
          ].max
        end
      end
    end

    max_values[items.length][@capacity]
  end
end
