package hamming

import "errors"

func Distance(a, b string) (int, error) {
    if len(a) != len(b) {
        return -1, errors.New("Arguments must be the same length.")
    }

    count := 0

    for i := range a {
        if a[i] != b[i] {
            count++
        }
    }

    return count, nil
}
