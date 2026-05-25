func canIBuy(vehicle: String, price: Double, monthlyBudget: Double) -> String {
    let fiveYearBudget = monthlyBudget * 60

    if price <= fiveYearBudget {
        return "Yes! I'm getting a \(vehicle)"
    }

    return price <= fiveYearBudget * 1.1
        ? "I'll have to be frugal if I want a \(vehicle)"
        : "Darn! No \(vehicle) for me"
}

func licenseType(numberOfWheels wheels: Int) -> String {
    if [2, 3].contains(wheels) {
        return "You will need a motorcycle license for your vehicle"
    }
    else if [4, 6].contains(wheels) {
        return "You will need an automobile license for your vehicle"
    }

    return wheels == 18
        ? "You will need a commercial trucking license for your vehicle"
        : "We do not issue licenses for those types of vehicles"
}

func calculateResellPrice(originalPrice: Int, yearsOld: Int) -> Int {
    if yearsOld < 3 {
        return originalPrice * 4 / 5
    }

    return yearsOld < 10
        ? originalPrice * 7 / 10
        : originalPrice / 2
}
