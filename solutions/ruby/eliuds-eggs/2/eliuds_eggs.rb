class EliudsEggs
  def self.egg_count(config)
    count   = 0
    current = config

    while current > 0
      count += current & 1
      current >>= 1
    end

    count
  end
end
