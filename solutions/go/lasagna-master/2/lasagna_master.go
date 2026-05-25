package lasagna

func PreparationTime(layers []string, minutesPerLayer int) int {
    if minutesPerLayer == 0 {
        minutesPerLayer = 2
    }

    return len(layers) * minutesPerLayer
}

func Quantities(layers []string) (noodles int, sauce float64) {
    for _, layer := range layers {
        if layer == "noodles" { noodles += 50  }
        if layer == "sauce"   { sauce   += 0.2 }
    }

    return
}

func AddSecretIngredient(friendIngredients []string, myIngredients []string) {
    friendLastIndex := len(friendIngredients) - 1
    myLastIndex     := len(myIngredients)     - 1

    myIngredients[myLastIndex] = friendIngredients[friendLastIndex]
}

func ScaleRecipe(quantities []float64, scale int) []float64 {
    scaledQuantities := make([]float64, len(quantities))

    for i, quantity := range quantities {
        scaledQuantities[i] = quantity * float64(scale) / 2.0
    }

    return scaledQuantities
}
