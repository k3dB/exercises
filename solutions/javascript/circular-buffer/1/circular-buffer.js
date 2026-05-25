class CircularBuffer {
  constructor(capacity) {
    this.capacity = capacity;
    this.buffer   = Array(capacity);
    this.clear();
  }

  write(item) {
    if (this.buffer.every(i => i != null)) {
      throw new BufferFullError();
    }

    this.buffer[this.writeIndex] = item;
    this.writeIndex = this.advance(this.writeIndex);
  }

  read() {
    if (this.buffer[this.readIndex] == null) {
      throw new BufferEmptyError();
    }

    const value = this.buffer[this.readIndex];
    this.buffer[this.readIndex] = null;
    this.readIndex = this.advance(this.readIndex);

    return value;
  }

  advance = (index) => (index + 1) % this.capacity;

  forceWrite(item) {
    if (this.buffer.some(i => i == null)) {
      this.write(item);
      return;
    }

    this.buffer[this.readIndex] = item;
    this.readIndex = this.advance(this.readIndex);
  }

  clear() {
    this.readIndex  = 0;
    this.writeIndex = 0;
    this.buffer.fill(null);
  }
}

export default CircularBuffer;

export class BufferFullError extends Error {
  constructor() {
    super('Cannot write to a full buffer.');
  }
}

export class BufferEmptyError extends Error {
  constructor() {
    super('Cannot read from an empty buffer.');
  }
}
