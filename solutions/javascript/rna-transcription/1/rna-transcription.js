export const toRna = (nucleotides) => {
  if (!nucleotides) return '';

  const replacements = {
    'G': 'C',
    'C': 'G',
    'T': 'A',
    'A': 'U'
  };

  return (
    nucleotides
      .split('')
      .map(n => replacements[n])
      .join('')
  );
};
