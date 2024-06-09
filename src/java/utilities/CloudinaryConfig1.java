package utilities;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Map;

public class CloudinaryConfig1 {

    private static Cloudinary cloudinary;

    static {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dsuyc27sj",
                "api_key", "445822965799267",
                "api_secret", "xJYRukopEUMswd9AGLGBvFuJhag"));
    }

    public static Map upLoadFile(InputStream inputStream, String fileName) {
        try {
            File file = convertInputStreamToFile(inputStream, fileName);
            Map uploadReulst = cloudinary.uploader().upload(file, ObjectUtils.emptyMap());
            file.delete();
            return uploadReulst;
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static File convertInputStreamToFile(InputStream inputStream, String fileName) {
        try {
            File file = new File(System.getProperty("java.io.tmpdir") + "/" + fileName);
            try (FileOutputStream outputStream = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while((bytesRead = inputStream.read(buffer))!=-1){
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
            return file;
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.println();
    }
}
