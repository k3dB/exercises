class Bucket {
  constructor(capacity) {
    this.capacity = capacity;
    this.amount   = 0;
  }

  fill(amount) {
    if (typeof amount === 'undefined') amount = this.capacity;
    this.amount += amount;
  }

  drain(amount) {
    if (typeof amount === 'undefined') amount = this.amount;
    this.amount -= amount;
  }

  freeAmount() {
    return this.capacity - this.amount;
  }

  pourInto(bucket) {
    const displacement = this.amount >= bucket.freeAmount()
      ? bucket.freeAmount()
      : this.amount;

    bucket.fill(displacement);
    this.drain(displacement);
  }

  isFull() {
    return this.amount === this.capacity;
  }
}

export class TwoBucket {
  #solution = { moves: 0, goalBucket: '', otherBucket: 0 };

  constructor(smallSize, largeSize, goal, startingBucket) {
    const bucketOne         = 'one';
    const bucketTwo         = 'two';
    const startsWithOne     = startingBucket === bucketOne;
    const nonStartingBucket = startsWithOne ? bucketTwo : bucketOne;

    let firstBucket  = new Bucket(startsWithOne ? smallSize : largeSize);
    let secondBucket = new Bucket(startsWithOne ? largeSize : smallSize);
    let states       = [];

    while (!this.#solution.goalBucket) {
      const state = [firstBucket.amount, secondBucket.amount];

      if (states.some(s => s[0] === state[0] && s[1] === state[1])) {
        throw new Error('Unreachable goal.');
      }

      states.push(state);
      this.#solution.moves++;

      if (this.#solution.moves === 1) {
        firstBucket.fill(); // Must fill first bucket on first move.
      }
      else if (this.#solution.moves === 2 && secondBucket.capacity === goal) {
        secondBucket.fill(); // Edge case shortcut to reach goal on second move.
      }
      else if (this.#solution.moves % 2 === 0) {
        firstBucket.pourInto(secondBucket);
      }
      else if (secondBucket.isFull()) {
        secondBucket.drain();
      }
      else {
        firstBucket.fill();
      }

      if (firstBucket.amount === goal) {
        this.#solution.goalBucket = startingBucket;
      }
      else if (secondBucket.amount === goal) {
        this.#solution.goalBucket = nonStartingBucket;
      }
    }

    this.#solution.otherBucket = this.#solution.goalBucket === startingBucket
      ? secondBucket.amount
      : firstBucket.amount;
  }

  solve() {
    return this.#solution;
  }
}
