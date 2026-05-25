class Array
  def keep(&block)
    return self.to_enum if !block_given?
    result = []
    self.each { |x| result << x if yield(x) }
    result
  end

  def discard(&block)
    return self.to_enum if !block_given?
    result = []
    self.each { |x| result << x if !yield(x) }
    result
  end
end
