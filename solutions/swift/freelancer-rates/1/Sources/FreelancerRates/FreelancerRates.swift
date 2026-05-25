let workHoursPerDay: Double = 8.0
let daysInMonth: Double = 22.0
let fullPercentage: Double = 100.0

func dailyRateFrom(hourlyRate: Int) -> Double {
    Double(hourlyRate) * workHoursPerDay
}

func monthlyRateFrom(
    hourlyRate: Int,
    withDiscount discount: Double) -> Double {

    let normalMonth = daysInMonth * dailyRateFrom(hourlyRate: hourlyRate)
    return discountedAmount(normalMonth, discount).rounded()
}

func workdaysIn(
    budget: Double,
    hourlyRate: Int,
    withDiscount discount: Double) -> Double {

    let discountedRate = discountedAmount(Double(hourlyRate), discount)
    return (budget / discountedRate / workHoursPerDay).rounded(.down)
}

func discountedAmount(_ amount: Double, _ discount: Double) -> Double {
    amount - amount * discount / fullPercentage
}
