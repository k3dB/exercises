class Palindromes
  def initialize(max_factor: nil, min_factor: 1)
    @min_factor = min_factor
    @max_factor = max_factor
    @sets = {}
  end

  def generate
    (@min_factor..@max_factor).each do |i|
      (i..@max_factor).each do |j|
        value = i * j
        factors = [i, j]

        if @sets.has_key?(value)
          @sets[value].factors << factors
        else
          @sets[value] = PalindromeSet.new(value, factors) if palindrome?(value)
        end
      end
    end
  end

  def smallest
    @sets[@sets.keys.min]
  end

  def largest
    @sets[@sets.keys.max]
  end

  private

  def palindrome?(value)
    value.to_s == value.to_s.chars.reverse.join
  end
end

class PalindromeSet
  attr_accessor :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = [factors]
  end
end
