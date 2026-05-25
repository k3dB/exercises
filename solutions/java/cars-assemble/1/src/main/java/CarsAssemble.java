public class CarsAssemble {

    private static final double BASE_PRODUCTION_RATE = 221.0;

    public double productionRatePerHour(int speed) {
        double baseProduction = speed * BASE_PRODUCTION_RATE;

        if (speed <= 4) {
            return baseProduction;
        }
        else if (speed <= 8) {
            return baseProduction * 0.9;
        }

        return speed == 9
          ? baseProduction * 0.8
          : baseProduction * 0.77;
    }

    public int workingItemsPerMinute(int speed) {
        return (int)Math.floor(productionRatePerHour(speed)) / 60;
    }
}
