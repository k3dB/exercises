export function totalBirdCount(birdsPerDay) {
  const days = birdsPerDay.length;
  let total = 0;

  for (let i = 0; i < days; i++) {
    total += birdsPerDay[i];
  }

  return total;
}

export function birdsInWeek(birdsPerDay, week) {
  const start = (week - 1) * 7;
  const end   = start + 7;

  let total = 0;

  for (let i = start; i < end; i++) {
    total += birdsPerDay[i];
  }

  return total;
}

export function fixBirdCountLog(birdsPerDay) {
  const days = birdsPerDay.length;

  for (let i = 0; i < days; i += 2) {
    birdsPerDay[i]++;
  }

  return birdsPerDay;
}
