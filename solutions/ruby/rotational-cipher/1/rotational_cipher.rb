class RotationalCipher
  def self.rotate(text, key)
    cipher = ""

    text.each_char do |c|
      current = c
      key.times { current = current.succ } if c.match?(/[A-Za-z]/)
      cipher << current.chars.last
    end

    cipher
  end
end
