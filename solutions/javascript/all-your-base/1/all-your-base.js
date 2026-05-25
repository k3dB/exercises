const invalidDigits = (digits, input_base) => {
  return (!Array.isArray(digits)
    || digits.length === 0
    || digits.length > 1 && digits[0] === 0
    || digits.some(d => d < 0 || d >= input_base)
  );
};

const invalidBase = (base) => base < 2;

export const convert = (digits, input_base, output_base) => {
  if (invalidBase(input_base))           throw new Error('Wrong input base');
  if (invalidBase(output_base))          throw new Error('Wrong output base');
  if (invalidDigits(digits, input_base)) throw new Error('Input has wrong format');

  let base10 = 0;
  let exponent = digits.length - 1;

  for (const digit of digits) {
    base10 += digit * input_base ** exponent;
    exponent--;
  }

  if (output_base === 10) {
    return base10.toString().split('').map(d => +d);
  }

  if (base10 === 0) return [0];

  let converted_digits = [];

  while (base10 > 0) {
    let digit = base10 % output_base;
    converted_digits.unshift(digit);
    base10 = Math.floor(base10 / output_base);
  }

  return converted_digits;
};
