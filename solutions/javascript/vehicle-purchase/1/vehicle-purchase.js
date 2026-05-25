export function needsLicense(kind) {
  return kind === 'car' || kind === 'truck';
}

export function chooseVehicle(option1, option2) {
  let best = [option1, option2].sort()[0];
  return `${best} is clearly the better choice.`;
}

export function calculateResellPrice(originalPrice, age) {
  if (age < 3) {
    return originalPrice * 0.80
  }
  else if (age >= 3 && age <= 10) {
    return originalPrice * 0.70
  }

  return originalPrice * 0.50
}
