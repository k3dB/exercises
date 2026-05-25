NF {
    for (i = length($0); i > 0; i--)
        printf "%s", substr($0, i, 1)
}
