export function cookingStatus(minutes) {
  if (minutes === 0) {
    return 'Lasagna is done.';
  }

  if (typeof minutes === 'number') {
    return 'Not done, please wait.';
  }

  return 'You forgot to set the timer.';
}

export function preparationTime(layers, minutes = 2) {
  return layers.length * minutes;
}

export function quantities(layers) {
  let noodles = 0;
  let sauce   = 0;

  layers.forEach(layer => {
    if (layer === 'noodles') {
      noodles += 1;
    }

    if (layer === 'sauce') {
      sauce += 1;
    }
  });

  return {
    noodles: noodles * 50,
    sauce: sauce * 0.2
  };
}

export function addSecretIngredient(friendIngredients, myIngredients) {
  myIngredients.push(friendIngredients[friendIngredients.length -1]);
}

export function scaleRecipe(recipe, portionCount = 0) {
  let scaled = {};

  Object.keys(recipe).forEach(key => {
    scaled[key] = recipe[key] / 2.0 * portionCount;
  });

  return scaled;
}
