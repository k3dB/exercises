class Array
  def accumulate(&block)
    return self.to_enum if !block_given?
    result = []
    self.each { |x| result << yield(x) }
    result
  end
end
