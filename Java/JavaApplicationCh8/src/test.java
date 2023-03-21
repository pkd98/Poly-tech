import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

public class test {

    public static void main(String[] args) {
        
        URL url = null;
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedOutputStream bos = null;
        
        try {
            
            // output
            bos = new BufferedOutputStream(new FileOutputStream("icon.ico"));
          
            // input
            url = new URL("https://alimipro.com/favicon.ico");
            is = url.openStream();
            isr = new InputStreamReader(is);
            
            int i = isr.read();
            while (i != -1) {
                bos.write(i);
                i = isr.read();
            }
            
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                isr.close();
                bos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
