export class BankAccount {
  #balance = 0;
  #isOpen  = false;

  open() {
    if (this.#isOpen) {
      throw new ValueError();
    }

    this.#balance = 0;
    this.#isOpen  = true;
  }

  close() {
    if (!this.#isOpen) {
      throw new ValueError();
    }

    this.#isOpen = false;
  }

  deposit(amount) {
    if (!this.#isOpen || amount < 0) {
      throw new ValueError();
    }

    this.#balance += amount
  }

  withdraw(amount) {
    if (!this.#isOpen || amount > this.#balance || amount < 0) {
      throw new ValueError();
    }

    this.#balance -= amount;
  }

  get balance() {
    if (!this.#isOpen) {
      throw new ValueError();
    }

    return this.#balance;
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}
