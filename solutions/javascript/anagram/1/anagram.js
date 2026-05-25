const getSortedLowerCase = (word) => {
  return (
    word
      .toLowerCase()
      .split('')
      .sort()
      .join('')
  );
};

export const findAnagrams = (word, candidates) => {
  const wordSortedLowerCase = getSortedLowerCase(word);

  return (
    candidates
      .filter(c => c.toLowerCase() !== word.toLowerCase()
        && getSortedLowerCase(c) === wordSortedLowerCase
      )
  );
};
