// @ts-check

/**
 * Calculates the sum of the two input arrays.
 *
 * @param {number[]} array1
 * @param {number[]} array2
 * @returns {number} sum of the two arrays
 */
export function twoSum(array1, array2) {
  let first  = +array1.reduce((a, c) => String(a) + String(c));
  let second = +array2.reduce((a, c) => String(a) + String(c));
  return first + second;
}

/**
 * Checks whether a number is a palindrome.
 *
 * @param {number} value
 * @returns {boolean} whether the number is a palindrome or not
 */
export function luckyNumber(value) {
  let reverse = String(value).split('').reverse().join('');
  return Number(reverse) === value;
}

/**
 * Determines the error message that should be shown to the user
 * for the given input value.
 *
 * @param {string|null|undefined} input
 * @returns {string} error message
 */
export function errorMessage(input) {
  if (!input) {
    return 'Required field';
  }

  let value = Number(input);

  return (
    value === 0 || isNaN(value)
      ? 'Must be a number besides 0'
      : ''
  );
}
