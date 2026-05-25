package lasagna

func PreparationTime(layers []string, minutesPerLayer int) int {
    if minutesPerLayer == 0 {
        minutesPerLayer = 2
    }

    return len(layers) * minutesPerLayer
}

func Quantities(layers []string) (noodles int, sauce float64) {
    noodleLayerCount := 0
    sauceLayerCount  := 0.0

    for _, layer := range layers {
        if layer == "noodles" {
            noodleLayerCount++
        }

        if layer == "sauce" {
            sauceLayerCount++
        }
    }

    noodles, sauce = noodleLayerCount * 50, sauceLayerCount * 0.2
    return
}

func AddSecretIngredient(friendIngredients []string, myIngredients []string) {
    friendLastIndex := len(friendIngredients) - 1
    myLastIndex     := len(myIngredients)     - 1

    myIngredients[myLastIndex] = friendIngredients[friendLastIndex]
}

func ScaleRecipe(quantities []float64, scale int) []float64 {
    scaledQuantities := make([]float64, len(quantities))
    copy(scaledQuantities, quantities)

    for i, quantity := range scaledQuantities {
        scaledQuantities[i] = quantity * float64(scale) / 2.0
    }

    return scaledQuantities
}
