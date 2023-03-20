import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;

public class Main {

    public static void main(String[] args) throws IOException {
        String msg = "Hello World";
        Reader reader = new StringReader(msg);
             
    }
    
    public static String fileRead(String fileName) throws IOException {
        String result = "";
        FileReader fr = new FileReader("data.txt");
        
        int ch = fr.read(); //char를 읽어오는데 int를 저장함
        
        while (ch != -1) {
            result += (char) ch;
            ch = fr.read();
        }
        return result;
    }
    
    public static void fileWriterCode() throws IOException {
        // 파일 열기, append 모드
        FileWriter fw = new FileWriter("data.txt", true);
        
        // 내용 작성
        fw.write("Hello World");
        fw.flush(); // 파일 쓰기 시작
        fw.close(); // 파일 닫기
    }
    
}
