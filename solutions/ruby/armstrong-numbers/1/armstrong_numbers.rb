class ArmstrongNumbers
  def self.include?(number)
    digits   = number.digits.reverse
    exponent = digits.count

    number == digits.reduce(0) { |s, d| s + d ** exponent }
  end
end
