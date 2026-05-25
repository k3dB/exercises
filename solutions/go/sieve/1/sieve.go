package sieve

import "math"

func Sieve(limit int) []int {
    candidates := make(map[int]bool)

    for i := 2; i <= limit; i++ {
        candidates[i] = true
    }

    squareRoot := int(math.Ceil(math.Sqrt(float64(limit))))

    for i := 2; i <= squareRoot; i++ {
        if !candidates[i] {
            continue
        }

        for j := i * i; j <= limit; j += i {
            candidates[j] = false
        }
    }

    primes := []int{}

    for i := 2; i <= limit; i++ {
        if candidates[i] {
            primes = append(primes, i)
        }
    }

    return primes
}
