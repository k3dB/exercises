using System;

static class SavingsAccount
{
    public static float InterestRate(decimal balance)
        => balance switch
        {
            < 0m    => -3.213f,
            < 1000m =>  0.5f,
            < 5000m =>  1.621f,
            _       =>  2.475f
        };

    public static decimal Interest(decimal balance)
        => balance * (decimal) Math.Abs(InterestRate(balance)) * 0.01m;

    public static decimal AnnualBalanceUpdate(decimal balance)
        => balance + Interest(balance);

    public static int YearsBeforeDesiredBalance(decimal balance, decimal targetBalance)
    {
        var years        = 0;
        var nextBalance  = balance;
        var originalDiff = targetBalance - balance;

        // Assumes we always want to get to a higher target balance
        while (nextBalance < targetBalance)
        {
            years++;
            nextBalance = AnnualBalanceUpdate(nextBalance);

            if (targetBalance - nextBalance >= originalDiff)
                return 0; // Diverges
        }

        return years;
    }
}
