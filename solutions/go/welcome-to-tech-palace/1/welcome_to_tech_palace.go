package techpalace

import (
    "strings"
    "unicode"
)

// WelcomeMessage returns a welcome message for the customer.
func WelcomeMessage(customer string) string {
    upperCasedName := strings.ToUpperSpecial(unicode.TurkishCase, customer)
    return "Welcome to the Tech Palace, " + upperCasedName
}

// AddBorder adds a border to a welcome message.
func AddBorder(welcomeMsg string, numStarsPerLine int) string {
    stars := strings.Repeat("*", numStarsPerLine)
    lines := []string{stars, welcomeMsg, stars}
    return strings.Join(lines, "\n")
}

// CleanupMessage cleans up an old marketing message.
func CleanupMessage(oldMsg string) string {
    starlessMessage := strings.ReplaceAll(oldMsg, "*", "")
    return strings.TrimSpace(starlessMessage)
}
