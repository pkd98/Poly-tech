package Observer;

import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        Button addButton = new Button(new OnClickEvent() {
            
            @Override
            public void onClick() {
                System.out.println("Click!");
            }
        });
        
        Button button2 = new Button(new OnClickEvent() {
            
            @Override
            public void onClick() {
                // TODO Auto-generated method stub
                System.out.println("클릭");
            }
        });
        
        List<Button> buttons = new ArrayList<>();
        buttons.add(addButton);
        buttons.add(button2);
        
        buttons.stream().forEach((button) -> button.click());
    }
}
