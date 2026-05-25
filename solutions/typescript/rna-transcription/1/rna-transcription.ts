export function toRna(strand: string): string {
  if (strand.match(/[^ACGT]/g)) {
    throw new Error('Invalid input DNA.')
  }

  let replacement = new Map()
  replacement.set('G', 'C')
  replacement.set('C', 'G')
  replacement.set('T', 'A')
  replacement.set('A', 'U')

  return (
    strand
      .split('')
      .map((c) => replacement.get(c))
      .join('')
  )
}
