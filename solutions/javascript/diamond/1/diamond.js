const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const space   = ' ';

export const rows = (letter) => {
  let diamond = [];

  const letterIndex = letters.indexOf(letter);
  const rowCount    = 2 * letterIndex + 1;

  let currentLetterIndex = 0;
  let outerSpaceCount    = letterIndex;

  for (let i = 0; i < rowCount; i++) {
    const currentLetter   = letters[currentLetterIndex];
    const letterCount     = currentLetterIndex === 0 ? 1 : 2;
    const innerSpaceCount = rowCount - letterCount - 2 * outerSpaceCount;
    const outer           = space.repeat(outerSpaceCount);
    const inner           = space.repeat(innerSpaceCount);
    const secondLetter    = letterCount === 1 ? '' : currentLetter;

    const row = `${outer}${currentLetter}${inner}${secondLetter}${outer}`;

    if (diamond.length < letterIndex) {
      currentLetterIndex++;
      outerSpaceCount--;
    }
    else {
      currentLetterIndex--;
      outerSpaceCount++;
    }

    diamond.push(row);
  }

  return diamond;
};
