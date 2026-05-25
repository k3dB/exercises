const getCode = (count, letter) => {
  return count === 1 ? letter : `${count}${letter}`;
};

export const encode = (text) => {
  if (!text) return text;

  let encoded = '';
  let letter  = text[0];
  let count   = 1;

  for (let i = 1; i < text.length; i++) {
    const current = text.charAt(i);

    if (current === letter) {
      count++;
    }
    else {
      encoded += getCode(count, letter);

      letter = current;
      count  = 1;
    }
  }

  encoded += getCode(count, letter);
  return encoded;
};

export const decode = (text) => {
  let decoded = '';
  let digits  = '';

  for (let i = 0; i < text.length; i++) {
    const current = text.charAt(i);

    let digit = current.match(/\d/);

    if (digit) {
      digits += digit;
    }
    else {
      const count = digits ? +digits : 1;

      for (let j = 0; j < count; j++) {
        decoded += current;
      }

      digits = '';
    }
  }

  return decoded;
};
