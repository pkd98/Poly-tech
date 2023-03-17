package Exam;

public class Main {

    public static void main(String[] args) {
        Gold gold = new Gold("3돈 금", 10000000);
        
        StrongBox<Gold> strongBox = new StrongBox<Gold>(KeyType.PADLOCK);
        strongBox.put(gold);
        
        for (int i = 0; i < 1024; i++) {
            Gold getGold = strongBox.get();

            if (getGold != null) {
                System.out.println(getGold);
            }
        }
    }
}
