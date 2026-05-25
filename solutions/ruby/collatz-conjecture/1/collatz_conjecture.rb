class CollatzConjecture
  def self.steps(number)
    raise ArgumentError if number < 1

    stepCount = 0
    currentValue = number

    while currentValue > 1
      if currentValue.even?
        currentValue /= 2
      else
        currentValue = 3 * currentValue + 1
      end

      stepCount += 1
    end

    stepCount
  end
end
