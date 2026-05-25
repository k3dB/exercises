class Integer
  def to_roman
    numeral = ""
    (1..self).each { |n| numeral << "I" }
    numeral
      .gsub(/IIIII/, "V").gsub(/IIII/, "IV")
      .gsub(/VV/,    "X").gsub(/VIV/,  "IX")
      .gsub(/XXXXX/, "L").gsub(/XXXX/, "XL")
      .gsub(/LL/,    "C").gsub(/LXL/,  "XC")
      .gsub(/CCCCC/, "D").gsub(/CCCC/, "CD")
      .gsub(/DD/,    "M").gsub(/DCD/,  "CM")
  end
end
