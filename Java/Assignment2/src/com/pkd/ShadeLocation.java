package com.pkd;

import java.util.Objects;

public class ShadeLocation implements Location {
    private int x;
    private int y;

    public ShadeLocation(int x, int y) {
        super();
        this.x = x;
        this.y = y;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        ShadeLocation other = (ShadeLocation) obj;
        return x == other.x && y == other.y;
    }

    @Override
    public String toString() {
        return "ShadeLocation [x=" + x + ", y=" + y + "]";
    }


}
