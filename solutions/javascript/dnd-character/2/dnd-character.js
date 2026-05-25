const baseHitpoints = 10;
const diceSides     =  6;

export const abilityModifier = (abilityScores) => {
  if (abilityScores < 3) {
    throw new Error('Ability scores must be at least 3');
  }

  if (abilityScores > 18) {
    throw new Error('Ability scores can be at most 18');
  }

  return Math.floor((abilityScores - baseHitpoints) / 2);
};

export class Character {
  #strength     = 0;
  #dexterity    = 0;
  #constitution = 0;
  #intelligence = 0;
  #wisdom       = 0;
  #charisma     = 0;
  #hitpoints    = 0;

  static rollAbility() {
    let lowestRoll = diceSides;
    let total      = 0;

    for (let i = 0; i < 4; i++) {
      const roll = Math.floor((Math.random() * (diceSides - 1)) + 1);

      if (roll < lowestRoll) {
        lowestRoll = roll;
      }

      total += roll;
    }

    return total - lowestRoll;
  }

  get strength() {
    if (!this.#strength) {
      this.#strength = Character.rollAbility();
    }

    return this.#strength;
  }

  get dexterity() {
    if (!this.#dexterity) {
      this.#dexterity = Character.rollAbility();
    }

    return this.#dexterity;
  }

  get constitution() {
    if (!this.#constitution) {
      this.#constitution = Character.rollAbility();
    }

    return this.#constitution;
  }

  get intelligence() {
    if (!this.#intelligence) {
      this.#intelligence = Character.rollAbility();
    }

    return this.#intelligence;
  }

  get wisdom() {
    if (!this.#wisdom) {
      this.#wisdom = Character.rollAbility();
    }

    return this.#wisdom;
  }

  get charisma() {
    if (!this.#charisma) {
      this.#charisma = Character.rollAbility();
    }

    return this.#charisma;
  }

  get hitpoints() {
    return baseHitpoints + abilityModifier(this.constitution)
  }
}
