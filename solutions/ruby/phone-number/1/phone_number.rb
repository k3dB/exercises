class PhoneNumber
  class << self
    COUNTRY_CODE           = "1"
    VALID_SIZE             = 10
    AREA_CODE_POSITION     = 0
    EXCHANGE_CODE_POSITION = 3
    MIN_CODE_START         = "2"

    def clean(text)
      digits = text.chars.select { |c| c =~ /[[:digit:]]/ }
      digits.shift if digits.first == COUNTRY_CODE
      valid?(digits) ? digits.join : nil
    end

    private

    def valid?(digits)
      digits.size == VALID_SIZE && 
      valid_code?(digits, AREA_CODE_POSITION) &&
      valid_code?(digits, EXCHANGE_CODE_POSITION)
    end

    def valid_code?(digits, position)
      digits[position] >= MIN_CODE_START
    end
  end
end
