export const primes = (limit) => {
  let candidates = [];
  let squareRoot = Math.ceil(Math.sqrt(limit));

  for (let i = 0; i < limit + 1; i++) {
    candidates.push({ value: i, isPrime: true });
  }

  candidates[0].isPrime = false;
  candidates[1].isPrime = false;

  for (let i = 2; i <= squareRoot; i++) {
    if (!candidates[i].isPrime) continue;

    for (let j = i**2; j <= limit; j += i) {
      candidates[j].isPrime = false;
    }
  }

  return candidates.filter(c => c.isPrime).map(c => c.value);
}
