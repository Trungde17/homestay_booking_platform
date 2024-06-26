
package utilities;
import java.text.NumberFormat;
import java.util.Locale;

public class CurrencyUtils {
    public static String formatCurrency(double amountInThousands){
        double amount=amountInThousands;
        Locale locale=new Locale("vi", "VN");
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);
        String formattedAmount=currencyFormatter.format(amount);
        return formattedAmount;
    }
    public static void main(String[] args) {
        System.out.println(formatCurrency(1000));
    }
}
