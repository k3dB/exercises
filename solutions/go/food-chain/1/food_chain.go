package foodchain

import (
    "fmt"
    "strings"
)

func Verse(verseNumber int) string {
    critters := GetCritters()
    incident := Incident(critters[verseNumber - 1])

    if verseNumber == len(critters) {
        return incident
    }

    recap := Recap(verseNumber, critters)
    tag   := Tag(critters)

    return incident + recap + tag
}

func Verses(start, end int) string {
    verses := []string{}

    for i := start; i <= end; i++ {
        verses = append(verses, Verse(i))
    }

    return strings.Join(verses, "\n\n")
}

func Song() string {
    return Verses(1, len(GetCritters()))
}

type Critter struct {
    Name    string
    Aside   string
    Epithet string
}

func GetCritters() []Critter {
    return []Critter {
        Critter {
            Name:    "fly",
            Aside:   "",
            Epithet: "",
            // ^^^ Last of the critter fields.
        },
        Critter {
            Name:    "spider",
            Aside:   "It wriggled and jiggled and tickled inside her.\n",
            Epithet: " that wriggled and jiggled and tickled inside her",
            // ^^^ Last of the critter fields.
        },
        Critter {
            Name:    "bird",
            Aside:   "How absurd to swallow a bird!\n",
            Epithet: "",
            // ^^^ Last of the critter fields.
        },
        Critter {
            Name:    "cat",
            Aside:   "Imagine that, to swallow a cat!\n",
            Epithet: "",
            // ^^^ Last of the critter fields.
        },
        Critter {
            Name:    "dog",
            Aside:   "What a hog, to swallow a dog!\n",
            Epithet: "",
            // ^^^ Last of the critter fields.
        },
        Critter {
            Name:    "goat",
            Aside:   "Just opened her throat and swallowed a goat!\n",
            Epithet: "",
            // ^^^ Last of the critter fields.
        },
        Critter {
            Name:    "cow",
            Aside:   "I don't know how she swallowed a cow!\n",
            Epithet: "",
            // ^^^ Last of the critter fields.
        },
        Critter {
            Name:    "horse",
            Aside:   "She's dead, of course!",
            Epithet: "",
            // ^^^ Last of the critter fields.
        },
        // ^^^ Last of the critters.
    }
}

func Incident(critter Critter) string {
    return fmt.Sprintf(
        "I know an old lady who swallowed a %s.\n%s",
        critter.Name,
        critter.Aside,
        // ^^^ Last of the fmt.Sprintf parameters.
    )
}

func Recap(verseNumber int, critters []Critter) string {
    recaps := []string{}

    for i:= verseNumber - 1; i >= 1; i-- {
        recaps = append(recaps, Motivation(critters[i], critters[i - 1]))
    }

    return strings.Join(recaps, "")
}

func Motivation(predator Critter, prey Critter) string {
    return fmt.Sprintf(
        "She swallowed the %s to catch the %s%s.\n",
        predator.Name,
        prey.Name,
        prey.Epithet,
        // ^^^ Last of the fmt.Sprintf parameters.
    )
}

func Tag(critters []Critter) string {
    return fmt.Sprintf(
        "I don't know why she swallowed the %s. Perhaps she'll die.",
        critters[0].Name,
        // ^^^ Last of the fmt.Sprintf parameters.
    )
}
