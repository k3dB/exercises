BEGIN {
    sounds[3] = "Pling"
    sounds[5] = "Plang"
    sounds[7] = "Plong"

    hasSounds = 0

    for (key in sounds) {
        if (num % key == 0) {
            printf "%s", sounds[key]
            hasSounds = 1
        }
    }

    if (!hasSounds)
        print num
}
