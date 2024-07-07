
package utilities;

import java.security.SecureRandom;
import java.util.Random;


public class random {
    public static String createOtpCode(){
        String otp_code="";
        for(int i =1; i <= 4; i++){
            otp_code+= new Random().nextInt(10);
        }
        return otp_code;
    }
    public static String generateRandomPassword(int length, String character) {
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(length);

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(character.length());
            password.append(character.charAt(index));
        }
        return password.toString();
    }
    public static void main(String[] args) {
        System.out.println(generateRandomPassword(5, "newioqknd iqonwdqmi290-1k2"));
    }
}
