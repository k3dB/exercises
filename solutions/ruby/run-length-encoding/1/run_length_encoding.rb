class RunLengthEncoding
  class << self
    def encode(text)
      return text if text.empty?
      code   = ""
      count  = 0
      chars  = text.chars
      letter = chars.first

      while !chars.empty?
        c = chars.shift
        if c == letter
          count += 1
        else
          build_code!(code, count, letter)
          letter = c
          count  = 1
        end
      end

      build_code!(code, count, letter)
    end

    def decode(code)
      return code if code.empty?
      text  = ""
      chars = code.chars

      while !chars.empty?
        c = chars.shift
        if c.to_s.match?(/\d/)
          chars.unshift(c)
          count = chars.join.to_i
          build_text!(text, count, chars)
        else
          text << c
        end
      end

      text
    end

    private

    def build_code!(code, count, letter)
      code << count.to_s if count > 1
      code << letter.to_s
    end

    def build_text!(text, count, chars)
      letter = ""
      (count.to_s.length + 1).times { letter = chars.shift }
      count.times { text << letter }
    end
  end
end
