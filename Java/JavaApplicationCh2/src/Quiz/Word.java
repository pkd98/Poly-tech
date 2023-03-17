package Quiz;

public class Word {
    private String letters;

    public Word(String letters) {
        this.letters = letters;
    }

    // i 번째 글자가 모음인지 확인

    public boolean isVowel(int i) {
        return "aeiouAEIOU".contains(letters.substring(i, i + 1));
    }

    // i 번째가 자음인지 확인
    public boolean isConsonant(int i) {
        return !isVowel(i);
    }
}
