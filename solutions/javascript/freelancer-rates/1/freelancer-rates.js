export const HOURS_PER_DAY           =  8;
export const BILLABLE_DAYS_PER_MONTH = 22;

export function dayRate(ratePerHour) {
  return ratePerHour * HOURS_PER_DAY;
}

export function daysInBudget(budget, ratePerHour) {
  let ratePerDay = dayRate(ratePerHour);
  return ratePerDay === 0 ? 0 : Math.floor(budget / ratePerDay);
}

export function priceWithMonthlyDiscount(ratePerHour, numDays, discount) {
  let ratePerDay     = dayRate(ratePerHour);
  let discountMonths = Math.floor(numDays / BILLABLE_DAYS_PER_MONTH);
  let discountDays   = discountMonths * BILLABLE_DAYS_PER_MONTH;
  let discountAmount = discountDays * ratePerDay * discount;
  let fullAmount     = numDays * ratePerDay;

  return Math.ceil(fullAmount - discountAmount);
}
