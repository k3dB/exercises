class Translation
  def self.of_rna(strand)
    strand
      .split(/(.{3})/)
      .each_with_object([]) do |c, p|
        next if c.empty?
        protein = Protein.from_codon(c)
        break p if protein == "STOP"
        p << protein
      end
  end
end

class Protein
  CODONS = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }.freeze

  def self.from_codon(codon)
    raise InvalidCodonError.new(codon) unless CODONS.key?(codon)

    CODONS.fetch(codon)
  end
end

class InvalidCodonError < StandardError
  def initialize(codon)
    super("Invalid codon: #{codon}.")
  end
end
