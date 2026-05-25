class BirdWatcher {
    private final int[] birdsPerDay;
    private int today;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay.clone();
        today = this.birdsPerDay.length - 1;
    }

    public int[] getLastWeek() {
        return new int[] { 0, 2, 5, 3, 7, 8, 4 };
    }

    public int getToday() {
        return birdsPerDay[today];
    }

    public void incrementTodaysCount() {
        birdsPerDay[today]++;
    }

    public boolean hasDayWithoutBirds() {
        for (int day: birdsPerDay) {
            if (day == 0) {
                return true;
            }
        }

        return false;
    }

    public int getCountForFirstDays(int numberOfDays) {
        int total = 0;

        if (numberOfDays > birdsPerDay.length) {
            numberOfDays = birdsPerDay.length;
        }

        for (int i = 0; i < numberOfDays; i++) {
            total += birdsPerDay[i];
        }

        return total;
    }

    public int getBusyDays() {
        int busyDays = 0;

        for (int day: birdsPerDay) {
            if (day >= 5) {
                busyDays++;
            }
        }

        return busyDays;
    }
}
