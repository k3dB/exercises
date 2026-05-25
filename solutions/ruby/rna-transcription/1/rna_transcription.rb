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
      .map { |c| transcribe(c) }
      .join
  end

  def self.transcribe(nucleotide)
    key = nucleotide.to_sym
    return "" if !TRANSCRIPTIONS.key?(key)
    TRANSCRIPTIONS[key]
  end
end
