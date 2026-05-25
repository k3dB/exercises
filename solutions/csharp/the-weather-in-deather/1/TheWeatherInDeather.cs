using System;
using System.Collections.Generic;

public class WeatherStation
{
    private Reading reading;
    private List<DateTime> recordDates = new List<DateTime>();
    private List<decimal> temperatures = new List<decimal>();

    public void AcceptReading(Reading reading)
    {
        this.reading = reading;
        recordDates.Add(DateTime.Now);
        temperatures.Add(reading.Temperature);
    }

    public void ClearAll()
    {
        reading = new Reading();
        recordDates.Clear();
        temperatures.Clear();
    }

    public decimal LatestTemperature => reading.Temperature;
    public decimal LatestPressure => reading.Pressure;
    public decimal LatestRainfall => reading.Rainfall;
    public bool HasHistory => recordDates.Count > 1;

    public Outlook ShortTermOutlook
        => RunSelfTest() == State.Bad
            ? throw new ArgumentException()
            : reading.Pressure < 10m && reading.Temperature < 30m
                ? Outlook.Cool
                : reading.Temperature > 50m
                    ? Outlook.Good
                    : Outlook.Warm;

    public Outlook LongTermOutlook
        => reading.WindDirection switch
        {
            WindDirection.Northerly => Outlook.Cool,
            WindDirection.Southerly => Outlook.Good,
            WindDirection.Westerly  => Outlook.Rainy,
            WindDirection.Easterly when reading.Temperature >  20m => Outlook.Good,
            WindDirection.Easterly when reading.Temperature <= 20m => Outlook.Warm,
            _ => throw new ArgumentException()
        };

    public State RunSelfTest()
        => reading.Equals(new Reading())
            ? State.Bad
            : State.Good;
}

public struct Reading
{
    public decimal Temperature { get; }
    public decimal Pressure { get; }
    public decimal Rainfall { get; }
    public WindDirection WindDirection { get; }

    public Reading(
        decimal temperature,
        decimal pressure,
        decimal rainfall,
        WindDirection windDirection)
    {
        Temperature = temperature;
        Pressure = pressure;
        Rainfall = rainfall;
        WindDirection = windDirection;
    }
}

public enum State
{
    Good,
    Bad
}

public enum Outlook
{
    Cool,
    Rainy,
    Warm,
    Good
}

public enum WindDirection
{
    Unknown, // default
    Northerly,
    Easterly,
    Southerly,
    Westerly
}
