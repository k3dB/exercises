class Hamming

  def self.compute(original, copy)
    raise ArgumentError if original.size != copy.size

    copy.chars
      .each_index.select { |i| copy.chars[i] != original.chars[i] }
      .count
  end

end
