/// <reference path="./global.d.ts" />
//
// @ts-check

/**
 * Determine the price of the pizza given the pizza and optional extras
 *
 * @param {Pizza} pizza name of the pizza to be made
 * @param {Extra[]} extras list of extras
 *
 * @returns {number} the price of the pizza
 */
export function pizzaPrice(pizza, ...extras) {
  let basePrice = 0;

  switch (pizza) {
    case 'Margherita':
      basePrice = 7;
      break;
    case 'Caprese':
      basePrice = 9;
      break;
    case 'Formaggio':
      basePrice = 10;
      break;
    default:
      throw new Error('Invalid pizza type: ' + pizza);
  }

  const sauceCount   = extras.filter(e => e === 'ExtraSauce'   ).length;
  const toppingCount = extras.filter(e => e === 'ExtraToppings').length;

  return basePrice + sauceCount + toppingCount * 2;
}

/**
 * Calculate the price of the total order, given individual orders
 *
 * (HINT: For this exercise, you can take a look at the supplied "global.d.ts" file
 * for a more info about the type definitions used)
 *
 * @param {PizzaOrder[]} pizzaOrders a list of pizza orders
 * @returns {number} the price of the total order
 */
export function orderPrice(pizzaOrders) {
  return pizzaOrders.reduce(
    (total, order) => total += pizzaPrice(order.pizza, ...order.extras),
    0
  );
}
