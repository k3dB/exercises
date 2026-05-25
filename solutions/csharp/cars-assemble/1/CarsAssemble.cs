using System;

static class AssemblyLine
{
    private const int BaseProductionRate = 221;
    private const int MinutesPerHour     = 60;

    public static double ProductionRatePerHour(int speed)
        => speed * BaseProductionRate * GetSuccessRate(speed);

    public static int WorkingItemsPerMinute(int speed)
        => (int) Math.Floor(ProductionRatePerHour(speed) / MinutesPerHour);

    private static double GetSuccessRate(int speed)
        => speed switch
        {
            <  5 => 1.00,
            <  9 => 0.90,
            < 10 => 0.80,
            _    => 0.77
        };
}
