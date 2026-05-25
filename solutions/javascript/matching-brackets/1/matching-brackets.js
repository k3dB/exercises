const pairs = {
  '(': ')',
  '[': ']',
  '{': '}'
};

export const isPaired = (text) => {
  let symbols = [];

  for (let i = 0; i < text.length; i++) {
    const current   = text.charAt(i);
    const isOpening = Object.keys  (pairs).includes(current);
    const isClosing = Object.values(pairs).includes(current);

    if (isOpening) {
      symbols.push(current);
    }

    if (isClosing && pairs[symbols.pop()] !== current) {
      return false;
    }
  }

  return symbols.length === 0;
};
