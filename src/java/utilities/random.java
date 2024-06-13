
package utilities;

import java.util.Random;


public class random {
    public static String createOtpCode(){
        String otp_code="";
        for(int i =1; i <= 4; i++){
            otp_code+= new Random().nextInt(10);
        }
        return otp_code;
    }
    public static void main(String[] args) {
        System.out.println(createOtpCode());
    }
}
