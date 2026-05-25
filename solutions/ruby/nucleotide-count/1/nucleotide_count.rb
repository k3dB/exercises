class Nucleotide
  def self.from_dna(sequence)
    DNA.new(sequence)
  end
end

class DNA
  NUCLEOTIDES        = %w[A T C G]
  NUCLEOTIDE_PATTERN = /[ATCG]/

  def initialize(sequence)
    raise ArgumentError unless sequence.gsub(NUCLEOTIDE_PATTERN, "").empty?
    @sequence = sequence
  end

  def count(nucleotide)
    @sequence.count(nucleotide)
  end

  def histogram
    NUCLEOTIDES.each_with_object(Hash.new) { |n, h| h[n] = count(n) }
  end
end
