class Grains
  BOARD_SIZE = 64

  def self.square(n)
    raise ArgumentError if !(1..BOARD_SIZE).include?(n)

    2**(n - 1)
  end

  def self.total
    2**(BOARD_SIZE) - 1
  end
end
