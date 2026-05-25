const validate = (invalidCase, errorMessage) => {
  if (invalidCase) {
    throw Error(errorMessage);
  }
};

const letterPattern  = /[A-Za-z]/;
const invalidPattern = /[^\d\s\-\.\(\)\+]/;

export const clean = (phoneNumber) => {
  validate(phoneNumber.match(letterPattern), 'Letters not permitted');
  validate(phoneNumber.match(invalidPattern), 'Punctuations not permitted');

  let digits = phoneNumber
    .split('')
    .filter(x => x.match(/\d/))
    .join('');

  validate(digits.length < 10, 'Incorrect number of digits');
  validate(digits.length > 11, 'More than 11 digits');

  validate(
    digits.length === 11 && !digits.startsWith('1'),
    '11 digits must start with 1'
  );

  digits = digits.length === 11 ? digits.substring(1) : digits;

  validate(digits[0] === '0', 'Area code cannot start with zero');
  validate(digits[0] === '1', 'Area code cannot start with one');

  validate(digits[3] === '0', 'Exchange code cannot start with zero');
  validate(digits[3] === '1', 'Exchange code cannot start with one');

  return digits;
};
