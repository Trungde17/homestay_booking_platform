/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

/**
 *
 * @author PC
 */
public class ImageFile {
    public static String detectMimeType(byte[] imageBytes) {
        if (imageBytes.length > 3 &&
            imageBytes[0] == (byte) 0xFF &&
            imageBytes[1] == (byte) 0xD8 &&
            imageBytes[2] == (byte) 0xFF) {
            return "image/jpeg";
        } else if (imageBytes.length > 4 &&
                   imageBytes[0] == (byte) 0x89 &&
                   imageBytes[1] == (byte) 0x50 &&
                   imageBytes[2] == (byte) 0x4E &&
                   imageBytes[3] == (byte) 0x47) {
            return "image/png";
        } else {
            return "application/octet-stream"; // Default binary type
        }
    }
}
