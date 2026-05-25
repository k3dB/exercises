class Critter {
  #name;
  #aside;
  #epithet;
  #article;

  constructor(name, aside, epithet = '', article = 'a') {
    this.#name    = name;
    this.#aside   = aside;
    this.#epithet = epithet;
    this.#article = article;
  }

  get name() {
    return this.#name;
  }

  get aside() {
    return this.#aside;
  }

  get epithet() {
    return this.#epithet;
  }

  get article() {
    return this.#article;
  }
}

const CRITTERS = [
  new Critter('fly', ''),
  new Critter(
    'spider',
    "It wriggled and jiggled and tickled inside her.\n",
    " that wriggled and jiggled and tickled inside her"
  ),
  new Critter('bird',  "How absurd to swallow a bird!\n"),
  new Critter('cat',   "Imagine that, to swallow a cat!\n"),
  new Critter('dog',   "What a hog, to swallow a dog!\n"),
  new Critter('goat',  "Just opened her throat and swallowed a goat!\n"),
  new Critter('cow',   "I don't know how she swallowed a cow!\n"),
  new Critter('horse', '')
];

class Verse {
  #verseNumber;
  #critters;

  constructor(verseNumber, critters) {
    this.#verseNumber = verseNumber;
    this.#critters    = critters;
  }

  toString() {
    return this.incident() + this.recap() + this.tag();
  }

  incident() {
    const critter = this.#critters[this.#verseNumber - 1];
    const details = `${critter.article} ${critter.name}.\n${critter.aside}`;
    return `I know an old lady who swallowed ${details}`;
  }

  recap() {
    let motivations = [];

    for (let i = this.#verseNumber - 1; i >= 1; i--) {
      motivations.push(
        this.motivation(this.#critters[i], this.#critters[i - 1])
      );
    }

    return motivations.join('');
  }

  motivation(predator, prey) {
    return `She swallowed the ${predator.name} to catch the ${prey.name}${prey.epithet}.\n`;
  }

  tag() {
    return `I don't know why she swallowed the ${this.#critters[0].name}. Perhaps she'll die.\n`
  }
}

class Conclusion extends Verse {
  recap() {
    return '';
  }

  tag() {
    return "She's dead, of course!\n";
  }
}

export class Song {
  #critters;

  constructor(critters = CRITTERS) {
    this.#critters = critters;
  }

  verse(verseNumber) {
    return (
      verseNumber === this.#critters.length
        ? new Conclusion (verseNumber, this.#critters).toString()
        : new Verse      (verseNumber, this.#critters).toString()
    );
  }

  verses(start, end) {
    let verses = [];

    for (let i = start; i <= end; i++) {
      verses.push(this.verse(i));
    }

    return verses.join('\n') + '\n';
  }
}
