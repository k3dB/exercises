class Prime
  def self.nth(n)
    raise ArgumentError if n < 1
    primes = [2]
    (3..).step(2) do |x|
      primes << x if self.prime?(x, primes)
      break if primes.size >= n + 1
    end
    primes[n - 1]
  end

  def self.prime?(x, primes)
    primes
      .select { |p| p <= Integer.sqrt(x) }
      .all?   { |p| x % p != 0 }
  end
end
