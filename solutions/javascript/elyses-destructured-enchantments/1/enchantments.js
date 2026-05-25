export function getFirstCard(deck) {
  let [first, ...rest] = deck;
  return first;
}

export function getSecondCard(deck) {
  let [first, second, ...rest] = deck;
  return second;
}

export function swapTopTwoCards(deck) {
  let [first, second, ...rest] = deck;
  return [second, first, ...rest];
}

export function discardTopCard(deck) {
  let [first, ...rest] = deck;
  return [first, rest];
}

const FACE_CARDS = ['jack', 'queen', 'king'];

export function insertFaceCards(deck) {
  let [first, ...rest] = deck;
  return [first, ...FACE_CARDS, ...rest];
}
