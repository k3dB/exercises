class Acronym
  def self.abbreviate(text)
    text
      .upcase
      .split(/[\-\s]+/)
      .map { |w| w[0] }
      .join
  end
end
