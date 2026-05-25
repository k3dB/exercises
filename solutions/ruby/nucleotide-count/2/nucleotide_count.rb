class Nucleotide
  def self.from_dna(sequence)
    DNA.new(sequence)
  end
end

class DNA
  NUCLEOTIDES = %w[A T C G].freeze

  attr_reader :histogram

  def initialize(sequence)
    @histogram = NUCLEOTIDES.each_with_object(Hash.new) { |n, h| h[n] = 0 }

    sequence.each_char do |c|
      raise ArgumentError unless NUCLEOTIDES.include?(c)
      @histogram[c] += 1
    end
  end

  def count(nucleotide)
    histogram.fetch(nucleotide)
  end
end
