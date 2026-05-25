package allergies

var allergens = map[string]uint{
    "eggs":           1,
    "peanuts":        2,
    "shellfish":      4,
    "strawberries":   8,
    "tomatoes":      16,
    "chocolate":     32,
    "pollen":        64,
    "cats":         128,
}

func Allergies(score uint) []string {
    var allergies = []string{}

    for allergen, _ := range allergens {
        if AllergicTo(score, allergen) {
            allergies = append(allergies, allergen)
        }
    }

    return allergies
}

func AllergicTo(score uint, allergen string) bool {
    mask := allergens[allergen]
    return score & mask == mask
}
