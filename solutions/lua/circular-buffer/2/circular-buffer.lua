local CircularBuffer = {}

local buffer      = {}
local capacity    = 0
local read_index  = 1
local write_index = 1

function CircularBuffer:new(size)
  setmetatable({}, self)
  capacity = size
  CircularBuffer:clear()
  return self
end

function CircularBuffer:clear()
  buffer      = {}
  read_index  = 1
  write_index = 1
end

function CircularBuffer:read()
  if buffer[read_index] == nil then
    error('buffer is empty')
  end

  item = buffer[read_index]
  buffer[read_index] = nil
  read_index = advance(read_index)
  return item
end

function CircularBuffer:write(item)
  if buffer[write_index] ~= nil then
    error('buffer is full')
  end

  if item == nil then return end

  buffer[write_index] = item
  write_index = advance(write_index)
end

function CircularBuffer:forceWrite(item)
  if any_empty() then
    return CircularBuffer:write(item)
  end

  buffer[read_index] = item
  read_index = advance(read_index)
end

function advance(index)
  return index % capacity + 1
end

function any_empty()
  for i = 1, capacity do
    if buffer[i] == nil then return true end
  end

  return false
end

return CircularBuffer
