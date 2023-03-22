package Observer;

public class Button {
    private OnClickEvent listener;
    
    public Button(OnClickEvent listener) {
        this.listener = listener;
    }

    void click() {
        listener.onClick();
    }
}
