class ParallelLetterFrequency
  class << self

    def count(texts)
      total_letter_counts = Hash.new(0)
      threads = []

      texts.each do |text|
        threads << Thread.new do
          count_single(text, total_letter_counts)
        end
      end

      threads.each(&:join)

      total_letter_counts
    end

    private

    def count_single(text, total_letter_counts)
      text
        .downcase
        .scan(/\p{L}/)
        .each { |c| total_letter_counts[c] += 1 }

      total_letter_counts
    end
  end
end
