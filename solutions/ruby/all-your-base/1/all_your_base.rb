class BaseConverter

  INVALID_INPUT_BASE  = "Input base must be greater than one."
  INVALID_OUTPUT_BASE = "Output base must be greater than one."
  NEGATIVE_DIGIT      = "Digits cannot be negative."
  INVALID_DIGIT       = "Digits must be valid per input base."

  def self.convert(input_base, digits, output_base)
    raise ArgumentError.new INVALID_INPUT_BASE  if input_base  <= 1
    raise ArgumentError.new INVALID_OUTPUT_BASE if output_base <= 1

    raise ArgumentError.new NEGATIVE_DIGIT if digits.any?(&:negative?)
    raise ArgumentError.new INVALID_DIGIT  if digits.any? { |d| d >= input_base }

    base10 = 0
    exponent = digits.length - 1

    digits.each do |digit|
      base10 += digit * input_base**exponent
      exponent -= 1
    end

    return base10.to_s.chars.map(&:to_i) if output_base == 10
    return [0] if base10.zero?

    converted_digits = []

    while base10 > 0
      digit = base10 % output_base
      converted_digits << digit
      base10 /= output_base
    end

    converted_digits.reverse
  end
end
