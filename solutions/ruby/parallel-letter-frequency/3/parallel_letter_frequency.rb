class ParallelLetterFrequency
  def self.count(texts)
    ractors = texts.map do |text|
      Ractor.new(text) do |text|
        text
          .gsub(/[^\p{L}]/, '')
          .downcase
          .each_grapheme_cluster
          .tally
      end
    end

    ractors.each_with_object(Hash.new(0)) do |ractor, count|
      ractor.take.each { |k, v| count[k] += v }
    end
  end
end
