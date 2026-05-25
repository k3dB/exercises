export function timeToMixJuice(name) {
  switch (name) {
    case 'Pure Strawberry Joy':
      return 0.5;
    case 'Energizer': // Same as Green Garden
    case 'Green Garden':
      return 1.5;
    case 'Tropical Island':
      return 3;
    case 'All or Nothing':
      return 5;
    default:
      return 2.5;
  }
}

export function limesToCut(wedgesNeeded, limes) {
  let wedgeCount = 0;
  let cloneLimes = [...limes];

  while (wedgeCount < wedgesNeeded && cloneLimes.length) {
    wedgeCount += getWedges(cloneLimes[0]);
    cloneLimes.shift();
  }

  return limes.length - cloneLimes.length;
}

const getWedges = (limeSize) => {
  switch (limeSize) {
    case 'small':
      return 6;
    case 'medium':
      return 8;
    case 'large':
      return 10;
    default:
      return 0;
  }
}

export function remainingOrders(timeLeft, orders) {
  let cloneOrders = [...orders];

  do {
    timeLeft -= timeToMixJuice(cloneOrders[0]);
    cloneOrders.shift();
  } while (timeLeft > 0);

  return cloneOrders;
}
