using System;

public class WeighingMachine
{
    public WeighingMachine(int precision)
    {
        Precision = precision;
    }

    public int Precision { get; init; }

    private double _weight;
    public double Weight
    {
       get => _weight;
       set
       {
           _weight = value;

           if (_weight < 0d)
               throw new ArgumentOutOfRangeException("Weight cannot be negative.");
       }
    }

    public double TareAdjustment { get; set; } = 5d;

    public string DisplayWeight
    {
        get
        {
            var weight = Math
                .Round(Weight - TareAdjustment, Precision)
                .ToString($"F{Precision}");

            return $"{weight} kg";
        }
    }
}
