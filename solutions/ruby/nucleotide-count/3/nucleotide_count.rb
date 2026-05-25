class Nucleotide
  def self.from_dna(sequence)
    DNA.new(sequence)
  end
end

class DNA
  attr_reader :histogram

  def initialize(sequence)
    raise ArgumentError unless sequence.gsub(/[ATCG]/, '').empty?

    @histogram = %w[A T C G]
      .each_with_object(Hash.new) { |n, h| h[n] = sequence.count(n) }
  end

  def count(nucleotide)
    histogram.fetch(nucleotide)
  end
end
