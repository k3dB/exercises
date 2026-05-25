export const valid = (id) => {
  const digits = id.replaceAll(' ', '');
  const length = digits.length;

  if (length < 2) return false;

  if (digits.match(/[^\d]/g)) return false;

  let shouldDouble = length % 2 === 0;
  let sumOfDigits  = 0;

  for (let i = 0; i < length; i++) {
    let digit = +digits[i];

    if (shouldDouble) digit *= 2;
    if (digit > 9)    digit -= 9;

    sumOfDigits += digit;
    shouldDouble = !shouldDouble;
  }

  return sumOfDigits % 10 === 0;
};
