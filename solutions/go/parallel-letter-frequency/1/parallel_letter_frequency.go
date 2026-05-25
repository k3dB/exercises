package letter

import "sync"

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
    var wg sync.WaitGroup

    for _, text := range texts {
        wg.Add(1)
        go GetFrequencies(text, frequencies, &wg)
    }

    wg.Wait()

    return frequencies
}

func GetFrequencies(text string, frequencies FreqMap, wg *sync.WaitGroup) {
    defer wg.Done()

    // TODO: Figure out what is needed for channels in this case to fix race conditions.
    for key, value := range Frequency(text) {
        frequencies[key] += value
    }
}
