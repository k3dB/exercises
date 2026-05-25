using System;
using System.Collections.Generic;
using System.Linq;

public interface IRemoteControlCar
{
    int DistanceTravelled { get; }
    void Drive();
}

public class ProductionRemoteControlCar
    : IRemoteControlCar,
     IComparable<ProductionRemoteControlCar>
{
    private int distanceTravelled;

    public int DistanceTravelled => distanceTravelled;
    public int NumberOfVictories { get; set; }

    public void Drive()
        => distanceTravelled += 10;

    public int CompareTo(ProductionRemoteControlCar other)
        => this.NumberOfVictories - other.NumberOfVictories;
}

public class ExperimentalRemoteControlCar : IRemoteControlCar
{
    private int distanceTravelled;

    public int DistanceTravelled => distanceTravelled;

    public void Drive()
        => distanceTravelled += 20;
}

public static class TestTrack
{
    public static void Race(IRemoteControlCar car)
        => car.Drive();

    public static List<ProductionRemoteControlCar> GetRankedCars(
        ProductionRemoteControlCar prc1,
        ProductionRemoteControlCar prc2)
        => new[] { prc1, prc2 }
            .OrderBy(c => c.NumberOfVictories)
            .ToList();
}
