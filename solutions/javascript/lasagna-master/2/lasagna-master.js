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
  return {
    noodles: layers.filter(layer => layer === 'noodles').length * 50,
    sauce:   layers.filter(layer => layer === 'sauce'  ).length * 0.2
  };
}

export function addSecretIngredient(friendIngredients, myIngredients) {
  myIngredients.push(friendIngredients[friendIngredients.length -1]);
}

export function scaleRecipe(recipe, portionCount = 0) {
  let scaled = {...recipe};

  for (const ingredient in scaled) {
    scaled[ingredient] *= portionCount / 2;
  };

  return scaled;
}
