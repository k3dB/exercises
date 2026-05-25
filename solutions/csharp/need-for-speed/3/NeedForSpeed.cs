using System;

public class RemoteControlCar
{
    private readonly int _speed;
    private readonly int _drain;

    private int _battery  = 100;
    private int _distance =   0;

    public RemoteControlCar(int speed, int drain)
    {
        if (speed <= 0)
            throw new ArgumentOutOfRangeException(nameof(speed));

        if (drain <= 0)
            throw new ArgumentOutOfRangeException(nameof(speed));

        _speed = speed;
        _drain = drain;
    }

    public bool BatteryDrained()
        => _battery == 0;

    public int DistanceDriven()
        => _distance;

    public void Drive()
    {
        if (BatteryDrained())
            return;

        _distance += _speed;
        _battery  -= _drain;

        if (!HasEnoughBattery())
            _battery = 0;
    }

    public static RemoteControlCar Nitro()
        => new (50, 4);

    private bool HasEnoughBattery()
        => _battery - _drain >= 0;
}

public class RaceTrack
{
    private readonly int _distance;

    public RaceTrack(int distance)
    {
        if (distance <= 0)
            throw new ArgumentOutOfRangeException(nameof(distance));

        _distance = distance;
    }

    public bool CarCanFinish(RemoteControlCar car)
    {
        car = car ?? throw new ArgumentNullException(nameof(car));

        while (!car.BatteryDrained())
        {
            car.Drive();

            if (car.DistanceDriven() >= _distance)
                return true;
        }

        return false;
    }
}
