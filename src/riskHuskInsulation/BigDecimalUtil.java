package riskHuskInsulation;
import java.math.BigDecimal;

public class BigDecimalUtil {
    public static BigDecimal getBigDecimal(String param) {
        try {
            return param != null && !param.isEmpty() ? new BigDecimal(param) : null;
        } catch (NumberFormatException e) {
            // Optionally log the error
            return null;
        }
    }
}
