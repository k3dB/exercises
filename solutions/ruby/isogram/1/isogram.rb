class Isogram

  def self.isogram?(text)
    letters = text.upcase.gsub(/[-\s]+/, '').chars
    letters.eql?(letters.uniq)
  end

end
