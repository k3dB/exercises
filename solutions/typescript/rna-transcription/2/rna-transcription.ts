export function toRna(strand: string): string {
  if (strand.match(/[^ACGT]/g)) {
    throw new Error('Invalid input DNA.')
  }

  let replacement = new Map<string, string>([
    ['G', 'C'],
    ['C', 'G'],
    ['T', 'A'],
    ['A', 'U']
  ])

  return (
    strand
      .split('')
      .map(nucleotide => replacement.get(nucleotide))
      .join('')
  )
}
