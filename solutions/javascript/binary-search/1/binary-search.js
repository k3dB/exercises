export const find = (items, searchItem) => {
  let lowerBound = 0;
  let upperBound = items.length - 1;

  while (lowerBound <= upperBound) {
    // IMPORTANT: Avoid addition overflow by distributing the half.
    const middleIndex = Math.floor(lowerBound / 2 + upperBound / 2);
    const middleItem  = items[middleIndex];

    if (middleItem === searchItem) return middleIndex;

    if (middleItem < searchItem) {
      lowerBound = middleIndex + 1;
    }
    else {
      upperBound = middleIndex - 1;
    }
  }

  throw new Error('Value not in array');
};
