const FIRST_PRIME = 2;

export const primes = (limit) => {
  let candidates = [];

  for (let i = FIRST_PRIME; i <= limit; i++) {
    candidates.push({ number: i, isPrime: false, visited: false });
  }

  while (!candidates.every(c => c.visited)) {
    const candidate = candidates.find(c => !c.visited);

    candidate.isPrime = true;

    const currentPrime = candidate.number;
    const currentIndex = candidates.indexOf(candidate);

    for (let i = currentIndex; i < candidates.length; i += currentPrime) {
      candidates[i].visited = true;
    }
  }

  return (
    candidates
      .filter(c => c.isPrime)
      .map(c => c.number)
  );
};
