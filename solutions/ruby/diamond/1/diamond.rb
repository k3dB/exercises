class Diamond
  LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  SPACE   = " "
  NEWLINE = "\n"

  def self.make_diamond(letter)
    diamond      = ""
    row_index    = 0
    letter_index = letter.ord - "A".ord
    height       = 2 * letter_index + 1

    current_letter_index = 0
    outer_space_count    = letter_index

    height.times do
      current_letter = LETTERS[current_letter_index]

      if current_letter_index.zero?
        letter_count = 1
      else
        letter_count = 2
      end

      inner_space_count = height - letter_count - 2 * outer_space_count

      diamond += SPACE * outer_space_count
      diamond += current_letter
      diamond += SPACE * inner_space_count
      diamond += current_letter unless letter_count == 1
      diamond += SPACE * outer_space_count

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
