package cars

// CalculateWorkingCarsPerHour calculates how many working cars are
// produced by the assembly line every hour.
func CalculateWorkingCarsPerHour(productionRate int, successRate float64) float64 {
    percent := successRate / 100.0
    return float64(productionRate) * percent
}

// CalculateWorkingCarsPerMinute calculates how many working cars are
// produced by the assembly line every minute.
func CalculateWorkingCarsPerMinute(productionRate int, successRate float64) int {
    perHour := CalculateWorkingCarsPerHour(productionRate, successRate)
    return int(perHour) / 60
}

// CalculateCost works out the cost of producing the given number of cars.
func CalculateCost(carsCount int) uint {
    groupCount := carsCount / 10
    individualCount := carsCount % 10

    groupCost := groupCount * 95000
    individualCost := individualCount * 10000

    return uint(groupCost + individualCost)
}
