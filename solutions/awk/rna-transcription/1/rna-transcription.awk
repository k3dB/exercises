END {
    nucleotides = $0
    transcription = ""

    for (i = 1; i <= length(nucleotides); i++) {
        if (substr(nucleotides, i, 1) == "C")
            transcription = transcription "G"
        else if (substr(nucleotides, i, 1) ==  "G")
            transcription = transcription "C"
        else if (substr(nucleotides, i, 1) == "T")
            transcription = transcription "A"
        else if (substr(nucleotides, i, 1) == "A")
            transcription = transcription "U"
        else {
            print "Invalid nucleotide detected."
            exit 1
        }
    }

    print transcription
}
