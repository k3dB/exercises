package letter

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(text string) FreqMap {
    frequencies := FreqMap{}
    for _, r := range text {
        frequencies[r]++
    }
    return frequencies
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(texts []string) FreqMap {
    frequencies := FreqMap{}
    ch := make(chan FreqMap)

    go func() {
        defer close(ch)
        for _, text := range texts {
            ch <- Frequency(text)
        }
    }()

    for frequency := range ch {
        for key, value := range frequency {
            frequencies[key] += value
        }
    }

    return frequencies
}
