class Array
  def accumulate(&block)
    return self if !block_given?
    self.map { |x| yield(x) }
  end
end
