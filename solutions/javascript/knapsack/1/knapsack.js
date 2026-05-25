export const knapsack = (maximumWeight, items) => {
  let maxValues = new Array(maximumWeight + 1).fill(0);

  items.forEach(item => {
    for (let weight = maximumWeight; weight >= item.weight; weight--) {
      maxValues[weight] = Math.max(
        maxValues[weight],
        maxValues[weight - item.weight] + item.value
      );
    }
  });

  return maxValues[maximumWeight];
};
