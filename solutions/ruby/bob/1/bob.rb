class Bob
  class << self
    def hey(remark)
      @remark = remark
      return RESPONSES[:shouting_question] if shouting_question?
      return RESPONSES[:question]          if question?
      return RESPONSES[:shout]             if shout?
      return RESPONSES[:space_only]        if space_only?
      RESPONSES[:default]
    end

    private

    attr_reader :remark

    RESPONSES = {
      shouting_question: "Calm down, I know what I'm doing!",
      question:          "Sure.",
      shout:             "Whoa, chill out!",
      space_only:        "Fine. Be that way!",
      default:           "Whatever."
    }.freeze

    def question?
      remark.rstrip.end_with?("?")
    end

    def shout?
      remark.eql?(remark.upcase) && has_letters?
    end

    def has_letters?
      remark.count("A-Za-z") > 0
    end

    def shouting_question?
      question? && shout?
    end

    def space_only?
      remark.strip.empty?
    end
  end
end
