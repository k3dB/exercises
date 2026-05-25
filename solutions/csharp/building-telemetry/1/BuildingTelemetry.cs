public class RemoteControlCar
{
    private int batteryPercentage = 100;
    private int distanceDrivenInMeters = 0;
    private string[] sponsors = new string[0];
    private int latestSerialNum = 0;

    public void Drive()
    {
        if (batteryPercentage <= 0)
            return;

        batteryPercentage -= 10;
        distanceDrivenInMeters += 2;
    }

    public void SetSponsors(params string[] sponsors)
        => this.sponsors = sponsors;

    public string DisplaySponsor(int sponsorNum)
        => sponsors[sponsorNum];

    public bool GetTelemetryData(
        ref int serialNum,
        out int batteryPercentage,
        out int distanceDrivenInMeters)
    {
        var isValidSerialNumber = serialNum >= latestSerialNum;

        batteryPercentage = isValidSerialNumber
            ? this.batteryPercentage
            : -1;

        distanceDrivenInMeters = isValidSerialNumber
            ? this.distanceDrivenInMeters
            : -1;

        if (isValidSerialNumber)
            latestSerialNum = serialNum;
        else
            serialNum = latestSerialNum;

        return isValidSerialNumber;
    }

    public static RemoteControlCar Buy()
        => new RemoteControlCar();
}

public class TelemetryClient
{
    private const string
        NoData = "no data",
        UsagePrefix = "usage-per-meter=";

    private RemoteControlCar car;

    public TelemetryClient(RemoteControlCar car)
    {
        this.car = car;
    }

    public string GetBatteryUsagePerMeter(int serialNum)
    {
        var isValid = car.GetTelemetryData(
          ref serialNum,
          out var batteryPercentage,
          out var distanceDrivenInMeters);

        return isValid && distanceDrivenInMeters > 0
            ? UsagePrefix + (100 - batteryPercentage) / distanceDrivenInMeters
            : NoData;
    }
}
