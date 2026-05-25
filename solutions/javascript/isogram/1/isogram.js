export const isIsogram = (phrase) => {
  const letters = phrase
    .toUpperCase()
    .replaceAll(/[-\s]/g, '')
    .split('');

  const uniqueLetters = new Set(letters);

  return letters.length === uniqueLetters.size;
};
