export function totalBirdCount(birdsPerDay) {
  let total = 0;

  for (let i = 0; i < birdsPerDay.length; i++) {
    total += birdsPerDay[i];
  }

  return total;
}

export function birdsInWeek(birdsPerDay, week) {
  let start = (week - 1) * 7;
  let total = 0;

  for (let i = start; i < start + 7; i++) {
    total += birdsPerDay[i];
  }

  return total;
}

export function fixBirdCountLog(birdsPerDay) {
  for (let i = 0; i < birdsPerDay.length; i += 2) {
    birdsPerDay[i]++;
  }

  return birdsPerDay;
}
