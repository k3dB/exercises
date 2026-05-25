const sounds = {
  3: 'Pling',
  5: 'Plang',
  7: 'Plong'
};

export const convert = (number) => {
  let sound = '';

  for (const key in sounds) {
    if (number % key === 0) {
      sound += sounds[key];
    }
  }

  return sound ? sound : number.toString();
};
