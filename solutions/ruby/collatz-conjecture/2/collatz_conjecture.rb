class CollatzConjecture
  class << self
    INVALID_MESSAGE = 'Number must be an integer greater than zero.'

    def steps(number)
      raise ArgumentError, INVALID_MESSAGE unless valid?(number)

      stepCount = 0

      while number > 1
        number = run_step(number)
        stepCount += 1
      end

      stepCount
    end

    private

    def valid?(number)
      number.integer? && number.positive?
    end

    def run_step(number)
      return number / 2 if number.even?
      3 * number + 1
    end
  end
end
