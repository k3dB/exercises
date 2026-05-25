class House {
  colors        = ['red', 'ivory', 'green', 'yellow', 'blue'];
  nationalities = ['Englishman', 'Spaniard', 'Ukrainian', 'Japanese', 'Norwegian'];
  pets          = ['dog', 'snail', 'fox', 'horse', 'zebra'];
  beverages     = ['coffee', 'tea', 'milk', 'orange juice', 'water'];
  hobbies       = ['dancing', 'painting', 'reading', 'football', 'chess'];
}

class Solver {
  #houses;
  #updated;
  #validTrial;

  constructor() {
    this.#houses = [];

    for (let i = 0; i < 5; i++) {
      this.#houses.push(new House());
    }
  }

  solve() {
    // Known "knowns"
    this.#known(this.#houses, 2, 'beverages', 'milk');
    this.#known(this.#houses, 0, 'nationalities', 'Norwegian');
    this.#known(this.#houses, 1, 'colors', 'blue');

    // Eliminate as much as possible by applying each rule one at a time.
    this.#runRulesUntilNothingIsRemoved(this.#houses);

    // Brute force the rest
    this.#trialAndError(this.#houses);

    return this.#houses;
  }

  #runRulesUntilNothingIsRemoved(houses) {
    this.#updated = true;
    while (this.#updated) {
      this.#updated = false;
      this.#runRules(houses);
    }
  }

  #known(houses, index, key, value) {
    houses[index][key] = [value];
    for (let i = 0; i < 5; i++) {
      if (i !== index) {
        this.#remove(houses, i, key, value);
      }
    }
  }

  #remove(houses, index, key, value) {
    const position = houses[index][key].indexOf(value);

    if (position === -1) return;

    houses[index][key].splice(position, 1);
    this.#updated = true;

    if (houses[index][key].length === 0) {
      this.#validTrial = false;
    }
  }

  #runRules(houses) {
    for (let i = 0; i < 5; i++) {
      this.#same(houses, i, 'nationalities', 'Englishman', 'colors', 'red');
      this.#same(houses, i, 'nationalities', 'Spaniard', 'pets', 'dog');
      this.#same(houses, i, 'colors', 'green', 'beverages', 'coffee');
      this.#same(houses, i, 'nationalities', 'Ukrainian', 'beverages', 'tea');
      this.#leftRight(houses, i, 'colors', 'ivory', 'colors', 'green');
      this.#same(houses, i, 'pets', 'snail', 'hobbies', 'dancing');
      this.#same(houses, i, 'colors', 'yellow', 'hobbies', 'painting');
      this.#nextTo(houses, i, 'hobbies', 'reading', 'pets', 'fox');
      this.#nextTo(houses, i, 'hobbies', 'painting', 'pets', 'horse');
      this.#same(houses, i, 'hobbies', 'football', 'beverages', 'orange juice');
      this.#same(houses, i, 'nationalities', 'Japanese', 'hobbies', 'chess');
    }

    for (let i = 0; i < 5; i++) {
      for (let j = 0; j < 5; j++) {
        if (i === j) continue;
        this.#checkSolved(houses, j, 'colors', i);
        this.#checkSolved(houses, j, 'nationalities', i);
        this.#checkSolved(houses, j, 'pets', i);
        this.#checkSolved(houses, j, 'beverages', i);
        this.#checkSolved(houses, j, 'hobbies', i);
      }
    }
  }

  #checkSolved(houses, checkedIndex, key, indexToRemove) {
    if (!this.#isSolved(houses, checkedIndex, key)) return;

    this.#remove(
      houses,
      indexToRemove,
      key,
      houses[checkedIndex][key][0]
    );
  }

  #isSolved(houses, index, key) {
    return houses[index][key].length === 1
  }

  #isSolution(houses, index, key, value) {
    return (
         houses[index][key].length === 1
      && houses[index][key][0]     === value
    );
  }

  #isPossibility(houses, index, key, value) {
    return houses[index][key].includes(value);
  }

  #same(houses, index, key1, value1, key2, value2) {
    if (!this.#isPossibility(houses, index, key1, value1)) {
      this.#remove(houses, index, key2, value2);
    }

    if (!this.#isPossibility(houses, index, key2, value2)) {
      this.#remove(houses, index, key1, value1);
    }

    if (this.#isSolution(houses, index, key1, value1)) {
      this.#known(houses, index, key2, value2);
    }

    if (this.#isSolution(houses, index, key2, value2)) {
      this.#known(houses, index, key1, value1);
    }
  }

  #leftRight(houses, index, leftKey, leftValue, rightKey, rightValue) {
    this.#remove(houses, 0, rightKey, rightValue);
    this.#remove(houses, 4, leftKey, leftValue);

    if (index < 4) {
      if (!this.#isPossibility(houses, index, leftKey, leftValue)) {
        this.#remove(houses, index + 1, rightKey, rightValue);
      }

      if (this.#isSolution(houses, index, leftKey, leftValue)) {
        this.#known(houses, index + 1, rightKey, rightValue);
      }

      if (this.#isSolution(houses, index + 1, rightKey, rightValue)) {
        this.#known(houses, index, leftKey, leftValue);
      }
    }

    if (index > 0) {
      if (!this.#isPossibility(houses, index, rightKey, rightValue)) {
        this.#remove(houses, index - 1, leftKey, leftValue);
      }

      if (this.#isSolution(houses, index, rightKey, rightValue)) {
        this.#known(houses, index - 1, leftKey, leftValue);
      }

      if (this.#isSolution(houses, index - 1, leftKey, leftValue)) {
        this.#known(houses, index, rightKey, rightValue);
      }
    }
  }

  #nextTo(houses, index, key1, value1, key2, value2) {
    if (this.#isSolution(houses, index, key1, value1)) {
      if (index === 0) {
        this.#known(houses, index + 1, key2, value2);
      }

      if (index === 4) {
        this.#known(houses, index - 1, key2, value2);
      }

      this.#remove(houses, index, key2, value2);

      for (let i = index + 2; i < 5; i++) {
        this.#remove(houses, i, key2, value2);
      }

      for (let i = index - 2; i >= 0; i--) {
        this.#remove(houses, i, key2, value2);
      }
    }

    if (this.#isSolution(houses, index, key2, value2)) {
      if (index === 0) {
        this.#known(houses, index + 1, key1, value1);
      }

      if (index === 4) {
        this.#known(houses, index - 1, key1, value1);
      }

      this.#remove(houses, index, key1, value1);

      for (let i = index + 2; i < 5; i++) {
        this.#remove(houses, i, key1, value1);
      }

      for (let i = index - 2; i >= 0; i--) {
        this.#remove(houses, i, key1, value1);
      }
    }
  }

  #trialAndError(houses) {
    for (let i = 0; i < 5; i++) {
      this.#runTrial(houses, i, 'colors');
      this.#runTrial(houses, i, 'nationalities');
      this.#runTrial(houses, i, 'pets');
      this.#runTrial(houses, i, 'beverages');
      this.#runTrial(houses, i, 'hobbies');
    }
  }

  #runTrial(houses, index, key) {
    if (houses[index][key].length === 1) return;

    let trialHouses  = JSON.parse(JSON.stringify(houses));
    this.#validTrial = true;

    for (let trial = 0; trial < trialHouses[index][key].length; trial++) {
      this.#known(trialHouses, index, key, trialHouses[index][key][trial]);
      this.#runRulesUntilNothingIsRemoved(trialHouses);

      if (!this.#validTrial) {
        this.#remove(houses, index, key, trialHouses[index][key][trial]);
        this.#runRulesUntilNothingIsRemoved(houses);
      }
    }
  }
}

export class ZebraPuzzle {
  #houses;

  constructor(solver = new Solver()) {
    this.#houses = solver.solve();
  }

  waterDrinker() {
    return this.#houses.find(h => h.beverages[0] === 'water').nationalities[0];
  }

  zebraOwner() {
    return this.#houses.find(h => h.pets[0] === 'zebra').nationalities[0];
  }
}
