import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

public class Main {

    public static void main(String[] args) {
        // try - catch - finally 사용을 위한 선언
        URL url = null;
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedOutputStream bos = null;

        try {
            // url 가져오기
            url = new URL("http://alimipro.com/favicon.ico");
            // url의 ico 파일 stream 데이터 가져오기
            is = url.openStream();
            // 해당 stream 데이터를 InputStreamReader로 받아옴
            isr = new InputStreamReader(is);

            // 출력을 저장할 BufferedOutputStream
            bos = new BufferedOutputStream(new FileOutputStream("icon.ico"));

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
