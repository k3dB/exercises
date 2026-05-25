END {
    is_leap_year = $0 % 4 == 0 \
        && $0 % 100 != 0 \
        || $0 % 400 == 0

    print is_leap_year ? "true" : "false"
}
