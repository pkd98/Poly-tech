package Quiz;

public class Main {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        String string = "Asdfesdfsdfisdfosdfu";
        Word word = new Word(string);
        
        for(int i = 0; i < string.length(); i++) {
            System.out.println(word.isVowel(i) + " " + word.isConsonant(i));
        }
    }
}
