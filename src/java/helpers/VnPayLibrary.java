package helpers;

import jakarta.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.Collator;
import java.util.*;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public class VnPayLibrary {

    public static final String VERSION = "2.1.0";
    private SortedMap<String, String> requestData = new TreeMap<>(new VnPayCompare());
    private SortedMap<String, String> responseData = new TreeMap<>(new VnPayCompare());

    public void addRequestData(String key, String value) {
        if (value != null && !value.isEmpty()) {
            requestData.put(key, value);
        }
    }

    public void addResponseData(String key, String value) {
        if (value != null && !value.isEmpty()) {
            responseData.put(key, value);
        }
    }

    public String getResponseData(String key) {
        return responseData.getOrDefault(key, "");
    }

    public String createRequestUrl(String baseUrl, String vnpHashSecret) throws NoSuchAlgorithmException, InvalidKeyException {
        StringBuilder data = new StringBuilder();
        for (Map.Entry<String, String> kv : requestData.entrySet()) {
            if (kv.getValue() != null && !kv.getValue().isEmpty()) {
                data.append(encode(kv.getKey())).append("=").append(encode(kv.getValue())).append("&");
            }
        }
        String queryString = data.toString();

        baseUrl += "?" + queryString;
        String signData = queryString;
        if (signData.length() > 0) {
            signData = signData.substring(0, signData.length() - 1);
        }
        String vnpSecureHash = Util.hmacSHA512(vnpHashSecret, signData);
        baseUrl += "vnp_SecureHash=" + vnpSecureHash;

        return baseUrl;
    }

    public boolean validateSignature(String inputHash, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
        String rspRaw = getResponseData();
        String myChecksum = Util.hmacSHA512(secretKey, rspRaw);
        return myChecksum.equalsIgnoreCase(inputHash);
    }

    private String getResponseData() {
        StringBuilder data = new StringBuilder();
        responseData.remove("vnp_SecureHashType");
        responseData.remove("vnp_SecureHash");
        for (Map.Entry<String, String> kv : responseData.entrySet()) {
            if (kv.getValue() != null && !kv.getValue().isEmpty()) {
                data.append(encode(kv.getKey())).append("=").append(encode(kv.getValue())).append("&");
            }
        }
        if (data.length() > 0) {
            data.deleteCharAt(data.length() - 1);
        }
        return data.toString();
    }

    private String encode(String value) {
        return java.net.URLEncoder.encode(value, StandardCharsets.UTF_8);
    }

    public static class Util {

        public static String hmacSHA512(String key, String inputData) throws NoSuchAlgorithmException, InvalidKeyException {
            Mac mac = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            mac.init(secretKeySpec);
            byte[] hashBytes = mac.doFinal(inputData.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hashBytes);
        }

        private static String bytesToHex(byte[] bytes) {
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        }

        public static String getIpAddress(HttpServletRequest request) {
            String ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null || ipAddress.isEmpty()) {
                ipAddress = request.getRemoteAddr();
            }

            if (ipAddress.equals("0:0:0:0:0:0:0:1")) {
                try {
                    InetAddress inetAddress = InetAddress.getLocalHost();
                    ipAddress = inetAddress.getHostAddress();
                } catch (UnknownHostException e) {
                    ipAddress = "127.0.0.1";
                }
            }

            return ipAddress;
        }
    }

    public static class VnPayCompare implements Comparator<String> {

        @Override
        public int compare(String x, String y) {
            if (x.equals(y)) {
                return 0;
            }
            if (x == null) {
                return -1;
            }
            if (y == null) {
                return 1;
            }
            return Collator.getInstance(Locale.US).compare(x, y);
        }
    }
}
