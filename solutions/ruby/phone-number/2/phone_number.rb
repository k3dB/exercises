class PhoneNumber
  class << self
    COUNTRY_CODE        = "1"
    VALID_SIZE          = 10
    AREA_CODE_START     = 0
    EXCHANGE_CODE_START = 3
    MIN_CODE_START      = "2"

    def clean(text)
      digits = text.chars.select { |c| c =~ /[[:digit:]]/ }
      digits.shift if digits.first == COUNTRY_CODE
      valid?(digits) ? digits.join : nil
    end

    private

    def valid?(digits)
      digits.size == VALID_SIZE && 
      valid_code?(digits, AREA_CODE_START) &&
      valid_code?(digits, EXCHANGE_CODE_START)
    end

    def valid_code?(digits, code_start)
      digits[code_start] >= MIN_CODE_START
    end
  end
end
