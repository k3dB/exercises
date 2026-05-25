export class GradeSchool {
  #roster   = new Map();
  #students = new Set();

  roster() {
    let roster = Object.fromEntries(this.#roster);

    for (const key of this.#roster.keys()) {
      roster[key] = [...this.#roster.get(key)];
    }

    return roster;
  }

  add(name, grade) {
    if (this.#students.has(name)) {
      for (const names of this.#roster.values()) {
        const index = names.indexOf(name);
        if (index !== -1) {
          names.splice(index, 1);
          break;
        }
      }
    }

    this.#students.add(name);

    if (!this.#roster.has(grade)) {
      this.#roster.set(grade, [name]);
    }
    else {
      this.#roster.get(grade).push(name);
      this.#roster.get(grade).sort();
    }
  }

  grade(grade) {
    if (!this.#roster.has(grade)) {
      return [];
    }

    return [...this.#roster.get(grade)];
  }
}
