const NUMBER_OF_LETTERS    = 26;
const LAST_LOWER_CASE_CODE = 'z'.charCodeAt(0);
const LAST_UPPER_CASE_CODE = 'Z'.charCodeAt(0);

const isLetter    = (character) => character.match(/[a-z]/i);
const isUpperCase = (character) => character === character.toUpperCase();

const isOutOfRange = (character, code) => {
  return (
        isUpperCase(character) && code > LAST_UPPER_CASE_CODE
    || !isUpperCase(character) && code > LAST_LOWER_CASE_CODE
  );
};

const getRotatedLetter = (character, key) => {
  const code = character.charCodeAt(0) + key;

  return (
    isOutOfRange(character, code)
      ? String.fromCharCode(code - NUMBER_OF_LETTERS)
      : String.fromCharCode(code)
  );
};

export const rotate = (text, key) => {
  let cipher = [];

  for (let i = 0; i < text.length; i++) {
    const character = text.charAt(i);

    if (!isLetter(character)) {
      cipher.push(character);
      continue;
    }

    cipher.push(getRotatedLetter(character, key));
  }

  return cipher.join('');
};
