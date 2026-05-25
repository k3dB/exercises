// Package weather provides information about the current weather conditions
// for a particular city.
package weather

// CurrentCondition represents the current condition of the weather.
var CurrentCondition string
// CurrentLocation represents the name of the city where the current weather
// condition is occurring.
var CurrentLocation string

// Forecast takes a city name and weather condition, updates the package's
// values of each, and returns a statement of the current weather condition
// of the given city.
func Forecast(city, condition string) string {
    CurrentLocation, CurrentCondition = city, condition
    return CurrentLocation + " - current weather condition: " + CurrentCondition
}
