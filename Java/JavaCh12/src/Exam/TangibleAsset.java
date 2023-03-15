package Exam;

public abstract class TangibleAsset extends Asset{
    private String name;
    private int price;
    private String color;
    
    public TangibleAsset(String name, int price, String color){
        this.name = name;
        this.price = price;
        this.color = color;
    }

    @Override
    public String getName() {
        return this.name;
    }

    @Override
    public int getPrice() {
        return this.price;
    }

    @Override
    public String getColor() {
        return this.color;
    }
    
}
