class Complement
  TRANSCRIPTIONS = {
    G: "C",
    C: "G",
    T: "A",
    A: "U"
  }

  def self.of_dna(sequence)
    sequence
      .to_s
      .upcase
      .chars
      .map { |c| TRANSCRIPTIONS[c.to_sym] }
      .join
  end
end
