const nextCollatz = (n) => {
  return (
    n % 2 === 0
      ? n / 2
      : 3 * n + 1
  );
};

export const steps = (n) => {
  if (n < 1) {
    throw new Error('Only positive numbers are allowed');
  }

  let count = 0;

  for ( ; n > 1; count++) {
    n = nextCollatz(n);
  }

  return count;
};
