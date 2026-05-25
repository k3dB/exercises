const PLANTS_PER_STUDENT   = 2;
const WINDOW_SEPARATOR     = '\n';
const PLANT_CODE_SEPARATOR = '';

const DEFAULT_STUDENTS = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
];

const PLANT_CODES = {
  G: 'grass',
  V: 'violets',
  R: 'radishes',
  C: 'clover',
};

export class Garden {
  #windowRows = [];
  #students   = [];

  constructor(diagram, students = DEFAULT_STUDENTS) {
    this.#windowRows = diagram.split(WINDOW_SEPARATOR);
    this.#students   = students.sort();
  }

  plants(student) {
    const startIndex = this.#students.indexOf(student) * PLANTS_PER_STUDENT;

    let locations  = [startIndex];
    let plantCodes = [];

    for (let i = 1; i < PLANTS_PER_STUDENT; i++) {
      locations.push(startIndex + i);
    }

    this.#windowRows.forEach(row => {
      const rowPlantCodes = row.split(PLANT_CODE_SEPARATOR);

      for (let i = 0; i < locations.length; i++) {
        plantCodes.push(rowPlantCodes[locations[i]]);
      }
    });

    return plantCodes.map(c => PLANT_CODES[c]);
  }
}
