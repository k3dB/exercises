class Luhn

  def self.valid?(id)
    valid_digits?(id.to_s) && luhn?(id.to_s)
  end

  private

  def self.valid_digits?(id)
    id.strip.length > 1 && all_chars_valid?(id)
  end

  def self.all_chars_valid?(id)
    id.chars.all? { |c| c.match?(/[\d\s]/) }
  end

  def self.luhn?(id)
    (doubled(digits(id)).sum % 10).zero?
  end

  def self.digits(id)
    id.chars
      .select { |c| !c.strip.empty? }
      .map    { |c| c.to_i  }
  end

  def self.doubled(digits)
    skip = true
    digits
      .reverse
      .map do |d|
        d *= 2 if !skip
        d -= 9 if d > 9 && !skip
        skip = !skip
        d
      end
  end

end
