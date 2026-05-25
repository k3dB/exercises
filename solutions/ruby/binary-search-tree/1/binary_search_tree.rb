class Bst
  attr_reader :left, :right, :data

  def initialize(value)
    @data = value
  end

  def insert(value)
    value <= data ? insert_left(value) : insert_right(value)
  end

  def each(&block)
    return self.to_enum if !block_given?
    in_order(self, &block)
  end

  private

  def insert_left(value)
    @left.nil? ? @left = Bst.new(value) : @left.insert(value)
  end

  def insert_right(value)
    @right.nil? ? @right = Bst.new(value) : @right.insert(value)
  end

  def in_order(node, &block)
    return if node.nil?
    in_order(node.left, &block)
    yield node.data
    in_order(node.right, &block)
  end
end
