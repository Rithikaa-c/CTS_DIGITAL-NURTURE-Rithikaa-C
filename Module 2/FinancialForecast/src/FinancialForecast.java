public class FinancialForecast {

    // Recursive Method
    public static double futureValue(double amount,
                                     double growthRate,
                                     int years) {

        // Base Case
        if (years == 0) {
            return amount;
        }

        // Recursive Call
        return futureValue(amount, growthRate,
                years - 1) * (1 + growthRate);
    }

    public static void main(String[] args) {

        double amount = 10000;
        double growthRate = 0.10; // 10%
        int years = 3;

        double result =
                futureValue(amount, growthRate, years);

        System.out.println("Future Value = ₹" + result);
    }
}