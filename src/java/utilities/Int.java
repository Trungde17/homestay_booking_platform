
package utilities;

import java.util.ArrayList;


public class Int {
    public static int[]convertStringListToIntegerList(String[]string_list){
        try {
            int[]result=new int[string_list.length];
            int i=0;
            for(String s : string_list){
                try {
                    int n = Integer.parseInt(s);
                    result[i]=n;
                    i++;
                } catch (Exception e) {
                }
            }
            return result;
        } catch (Exception e) {
        }
        return null;
    }
    
    public static void main(String[] args) {
        String[]ss = new String[]{"1", "2", "4"};
        int[]nn=convertStringListToIntegerList(ss);
        for(int n:nn){
            System.out.println(n);
        }
    }
}
