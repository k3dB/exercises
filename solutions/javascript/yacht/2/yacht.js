const scoreFullHouse = (rolls) => {
  if (rolls.length !== 5) return 0;

  const sorted = rolls.sort();

  if (sorted[0] !== sorted[4]
  &&  sorted[1] === sorted[0]
  &&  sorted[3] === sorted[4]
  && (sorted[2] === sorted[0] || sorted[2] === sorted[4])) {
    return rolls.reduce((sum, roll) => sum += roll);
  }

  return 0;
};

const scoreFourOfAKind = (rolls) => {
  if (rolls.length !== 5) return 0;

  const sorted     = rolls.sort();
  const first      = sorted[0];
  const last       = sorted[4];
  const first_four = sorted.slice(0, 4);
  const last_four  = sorted.slice(1, 5);

  if (first_four.every(r => r === first)) {
    return first * 4;
  }

  if (last_four.every(r => r === last)) {
    return last * 4;
  }

  return 0;
};

export const score = (rolls, category) => {
  switch (category) {
    case 'ones':
      return rolls.filter(r => r === 1).reduce((sum, roll) => sum += roll, 0);
    case 'twos':
      return rolls.filter(r => r === 2).reduce((sum, roll) => sum += roll, 0);
    case 'threes':
      return rolls.filter(r => r === 3).reduce((sum, roll) => sum += roll, 0);
    case 'fours':
      return rolls.filter(r => r === 4).reduce((sum, roll) => sum += roll, 0);
    case 'fives':
      return rolls.filter(r => r === 5).reduce((sum, roll) => sum += roll, 0);
    case 'sixes':
      return rolls.filter(r => r === 6).reduce((sum, roll) => sum += roll, 0);
    case 'full house':
      return scoreFullHouse(rolls);
    case 'four of a kind':
      return scoreFourOfAKind(rolls);
    case 'little straight':
      const little = [1, 2, 3, 4, 5];
      return rolls.sort().every((roll, i) => roll === little[i])  ? 30 : 0;
    case 'big straight':
      const big = [2, 3, 4, 5, 6];
      return rolls.sort().every((roll, i) => roll === big[i])  ? 30 : 0;
    case 'choice':
      return rolls.reduce((sum, roll) => sum += roll);
    case 'yacht':
      return rolls.every(r => r === rolls[0]) ? 50 : 0;
    default:
      return 0;
  }
};
