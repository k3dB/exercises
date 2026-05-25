export class InvalidInputError extends Error {
  constructor(message) {
    super();
    this.message = message || 'Invalid Input';
  }
}

export class Robot {
  #directions  = ['north', 'east', 'south', 'west'];
  #bearing     = 'north';
  #coordinates = [0, 0];

  get bearing() {
    return this.#bearing;
  }

  get coordinates() {
    return this.#coordinates;
  }

  place({ x, y, direction }) {
    if (!this.#directions.includes(direction)) {
      throw new InvalidInputError('Invalid direction');
    }

    this.#bearing     = direction;
    this.#coordinates = [x, y];
  }

  rotateRight() {
    let directionIndex = this.#directions.indexOf(this.#bearing) + 1;

    if (directionIndex >= this.#directions.length) {
      directionIndex = 0;
    }

    this.#bearing = this.#directions[directionIndex];
  }

  rotateLeft() {
    let directionIndex = this.#directions.indexOf(this.#bearing) - 1;

    if (directionIndex < 0) {
      directionIndex = this.#directions.length - 1;
    }

    this.#bearing = this.#directions[directionIndex];
  }

  advance() {
    switch (this.#bearing) {
      case 'north':
        this.#coordinates[1] += 1
        break;
      case 'south':
        this.#coordinates[1] -= 1
        break;
      case 'east':
        this.#coordinates[0] += 1
        break;
      case 'west':
        this.#coordinates[0] -= 1
        break;
    }
  }

  evaluate(instructions) {
    instructions.split('').forEach(i => {
      switch (i) {
        case 'R':
          this.rotateRight();
          break;
        case 'L':
          this.rotateLeft();
          break;
        case 'A':
          this.advance();
          break;
      }
    });
  }
}
