module InterestIsInteresting

let interestRate (balance: decimal): single =
    match balance with
        | b when b < 0m -> 3.213f
        | b when b < 1000m -> 0.5f
        | b when b < 5000m -> 1.621f
        | _ -> 2.475f

let percentage = 0.01m

let interest (balance: decimal): decimal =
   balance * decimal(interestRate balance) * percentage

let annualBalanceUpdate(balance: decimal): decimal =
   balance + interest balance

let amountToDonate(balance: decimal) (taxFreePercentage: float): int =
   let taxFreeAmount = (decimal taxFreePercentage) * percentage * 2m

   match balance with
       | b when b < 0m -> 0
       | _ -> int(balance * taxFreeAmount)
