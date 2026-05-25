BEGIN { FS = "" }
END {
    transcription = ""

    for (i = 1; i <= NF; i++) {
        if ($i == "C")
            transcription = transcription "G"
        else if ($i ==  "G")
            transcription = transcription "C"
        else if ($i == "T")
            transcription = transcription "A"
        else if ($i == "A")
            transcription = transcription "U"
        else {
            print "Invalid nucleotide detected." > "/dev/stderr"
            exit 1
        }
    }

    print transcription
}
