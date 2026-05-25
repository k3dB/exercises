// Due to the purpose of this exercise, I chose not to use the length property
// of Array or the following Array methods: push, concat, filter, map, reduce,
// reduceRight, or reverse.
export class List {

  constructor(values = []) {
    this.values = values;
  }

  append(list) {
    let index = this.length();

    list.values.forEach((value) => {
      this.values[index] = value;
      index++;
    });

    return this;
  }

  concat(listOfLists) {
    listOfLists.values.forEach((list) => this.append(list));
    return this;
  }

  filter(predicate) {
    let filteredItems = [];
    let index = 0;

    this.values.forEach((value) => {
      if (predicate(value)) {
        filteredItems[index] = value;
        index++;
      }
    });

    this.values = filteredItems;
    return this;
  }

  map(mutator) {
    const length = this.length();

    for (let i = 0; i < length; i++) {
      this.values[i] = mutator(this.values[i]);
    }

    return this;
  }

  length() {
    let count = 0;
    this.values.forEach((v) => count++);
    return count;
  }

  foldl(reducer, start) {
    let foldedValue = start;
    this.values.forEach((value) => foldedValue = reducer(foldedValue, value));
    return foldedValue;
  }

  foldr(reducer, start) {
    const length = this.length();
    let foldedValue = start;

    for (let i = length - 1; i >= 0; i--) {
      foldedValue = reducer(foldedValue, this.values[i]);
    }

    return foldedValue;
  }

  reverse() {
    const length = this.length();
    let reversedValues = [];
    let index = 0;

    for (let i = length - 1; i >= 0; i--) {
      reversedValues[index] = this.values[i];
      index++;
    }

    this.values = reversedValues;
    return this;
  }
}
