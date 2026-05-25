class CircularBuffer
  def initialize(size)
    @buffer      = Array.new(size)
    @read_index  = 0
    @write_index = 0
    @last_index  = size - 1
  end

  def clear
    @buffer.fill(nil)
    @read_index  = 0
    @write_index = 0
  end

  def read
    raise BufferEmptyException if @buffer[@read_index].nil?
    value = @buffer[@read_index]
    @buffer[@read_index] = nil
    @read_index = advance(@read_index)
    value
  end

  def write(value)
    raise BufferFullException if !@buffer[@write_index].nil?
    @buffer[@write_index] = value
    @write_index = advance(@write_index)
  end

  def write!(value)
    return write(value) if @buffer.any?(&:nil?)
    @buffer[@read_index] = value
    @read_index = advance(@read_index)
  end

  private

  def advance(index)
    return 0 if index == @last_index
    index + 1
  end
end

class CircularBuffer::BufferEmptyException < StandardError
  def initialize
    super("Cannot read from an empty buffer.")
  end
end

class CircularBuffer::BufferFullException < StandardError
  def initialize
    super("Cannot write to a full buffer.")
  end
end
