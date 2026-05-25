package hamming

import "fmt"

func Distance(a, b string) (int, error) {
    if len(a) != len(b) {
        return -1, fmt.Errorf("Arguments must be the same length.")
    }

    count := 0

    for i, _ := range a {
        if (a[i] != b[i]) {
            count++
        }
    }

    return count, nil
}
