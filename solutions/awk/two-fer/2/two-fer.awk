BEGIN { person = "you" }
NF { person = $0 }
END { printf "One for %s, one for me.", person }
