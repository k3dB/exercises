export const isArmstrongNumber = (candidate) => {
  const digits = candidate.toString();
  const count  = digits.length;

  let sum = 0;

  for (let i = 0; i < count; i++) {
    const digit = +digits[i];
    sum += digit ** count;
  }

  return sum === candidate;
};
