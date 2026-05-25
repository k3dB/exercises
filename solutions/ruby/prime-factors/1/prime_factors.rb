class PrimeFactors
  def self.of(number)
    factors  = []
    quotient = number
    factor   = 2

    until quotient == 1
      if quotient % factor == 0
        factors << factor 
        quotient /= factor
      else
        factor += 1 until quotient % factor == 0
      end
    end

    factors
  end
end
