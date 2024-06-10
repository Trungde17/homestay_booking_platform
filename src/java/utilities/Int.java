
package utilities;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;


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
    public static Map<Integer, Integer> countIntegers(int[] array) {
        Map<Integer, Integer> frequencyMap = new LinkedHashMap<>();

        for (Integer obj : array) {
            if (obj instanceof Integer) {
                int number = (Integer) obj;
                frequencyMap.put(number, frequencyMap.getOrDefault(number, 0) + 1);
            }
        }
        return frequencyMap;
    }
    
    public static void main(String[] args) {
        int[]arr=new int[]{1, 3, 6, 3, 3, 4, 5, 6, 5, 1};
        Map<Integer, Integer>map=countIntegers(arr);
        for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
            System.out.println(entry.getKey()+" " + entry.getValue());      
        }
    }
    
    
}
