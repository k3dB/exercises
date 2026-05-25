class Sieve
  attr_reader   :limit, :numbers
  attr_accessor :composites

  START = 2

  def initialize(limit)
    @limit      = limit
    @numbers    = (START..limit).to_a
    @composites = []
  end

  def primes
    numbers
      .each   { |n| collect_composites(n)   }
      .select { |n| !composites.include?(n) }
  end

  private

  def collect_composites(number)
    numbers
      .select { |n| n * number <= limit      }
      .each   { |n| composites << n * number }
  end
end
