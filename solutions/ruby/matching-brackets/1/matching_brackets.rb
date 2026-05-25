class Brackets
  OPENS  = %w"[ { (".freeze
  CLOSES = %w"] } )".freeze

  def self.paired?(text)
    symbols = []

    text.chars.each do |c|
      symbols << c if OPENS.include?(c)

      if CLOSES.include?(c)
        current = symbols.pop
        index   = CLOSES.index(c)
        return false unless OPENS.index(current) == index
      end
    end

    symbols.empty?
  end
end
