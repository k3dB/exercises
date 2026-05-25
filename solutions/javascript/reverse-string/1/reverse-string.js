export const reverseString = (text) => {
  let reversed = '';

  for (let i = text.length; i > 0; i--) {
    reversed += text.charAt(i - 1);
  }

  return reversed;
};
