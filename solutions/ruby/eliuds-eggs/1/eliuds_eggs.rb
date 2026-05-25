class EliudsEggs
  def self.egg_count(config)
    count   = 0
    current = config

    while current > 0
      if current.odd?
        count += 1
        current -= 1
      end

      current /= 2
    end

    count
  end
end
