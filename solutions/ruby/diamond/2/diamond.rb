class Diamond
  LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  SPACE   = " "
  NEWLINE = "\n"

  def self.make_diamond(letter)
    diamond      = ""
    letter_index = letter.ord - "A".ord
    row_index    = 0
    row_count    = 2 * letter_index + 1

    current_letter_index = 0
    outer_space_count    = letter_index

    row_count.times do
      current_letter    = LETTERS[current_letter_index]
      letter_count      = current_letter_index.zero? ? 1 : 2
      inner_space_count = row_count - letter_count - 2 * outer_space_count

      diamond << SPACE * outer_space_count
      diamond << current_letter
      diamond << SPACE * inner_space_count
      diamond << current_letter unless letter_count == 1
      diamond << SPACE * outer_space_count

      if row_index < letter_index
        current_letter_index += 1
        outer_space_count    -= 1
      else
        current_letter_index -= 1
        outer_space_count    += 1
      end

      diamond   += NEWLINE
      row_index += 1
    end

    diamond
  end
end
