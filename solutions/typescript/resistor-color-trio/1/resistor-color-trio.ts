const BILLION = 1_000_000_000
const MILLION = 1_000_000
const THOUSAND = 1_000

const COLORS: string[] = [
  'black',
  'brown',
  'red',
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white'
]

interface Simplification {
  amount: number,
  prefix: string
}

const colorValue = (color: string): number => COLORS.indexOf(color)

const baseValue = (colors: string[]): number =>
  10 * colorValue(colors[0]) + colorValue(colors[1])

const multiple = (colors: string[]): number =>
  Math.pow(10, colorValue(colors[2]))

export function decodedResistorValue(colors: string[]): string {
  let simplified = simplify(baseValue(colors) * multiple(colors))
  return `${simplified.amount} ${simplified.prefix}ohms`
}

function simplify(fullAmount: number): Simplification {
  let amount = fullAmount
  let prefix = ''

  if (amount === 0) {
    return { amount, prefix }
  }

  if (fullAmount % BILLION === 0) {
    amount /= BILLION
    prefix = 'giga'
  }
  else if (fullAmount % MILLION === 0) {
    amount /= MILLION
    prefix = 'mega'
  }
  else if (fullAmount % THOUSAND === 0) {
    amount /= THOUSAND
    prefix = 'kilo'
  }

  return { amount, prefix }
}
