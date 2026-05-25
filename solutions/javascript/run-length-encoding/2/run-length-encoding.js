const getCode = (count, letter) => {
  return count === 1 ? letter : `${count}${letter}`;
};

export const encode = (text) => {
  if (!text) return text;

  let encoded = '';
  let last    = text[0];
  let count   = 1;

  text.split('').reduce((previous, current) => {
    if (current === last) {
      count++;
    }
    else {
      encoded += getCode(count, last);
      last  = current;
      count = 1;
    }
  });

  encoded += getCode(count, last);
  return encoded;
};

export const decode = (text) => {
  let decoded = '';
  let digits  = '';

  for (let i = 0; i < text.length; i++) {
    const current = text.charAt(i);
    const digit   = current.match(/\d/);

    if (digit) {
      digits += digit;
    }
    else {
      const count = digits ? +digits : 1;
      decoded += current.repeat(count);
      digits = '';
    }
  }

  return decoded;
};
