package com.pkd;

import java.util.Objects;

/*
 * 공사장 위치 클래스 (x좌표, y좌표, 소음반경)
 */

public class ConstructionLocation implements Location {
    private int x;
    private int y;
    private int magnitudeOfNoise;

    public ConstructionLocation(int x, int y, int magnitudeOfNoise) {
        this.x = x;
        this.y = y;
        this.magnitudeOfNoise = magnitudeOfNoise;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public int getMagnitudeOfNoise() {
        return magnitudeOfNoise;
    }

    @Override
    public int hashCode() {
        return Objects.hash(magnitudeOfNoise, x, y);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        ConstructionLocation other = (ConstructionLocation) obj;
        return magnitudeOfNoise == other.magnitudeOfNoise && x == other.x && y == other.y;
    }

    @Override
    public String toString() {
        return "ConstructionLocation [x=" + x + ", y=" + y + ", magnitudeOfNoise="
                + magnitudeOfNoise + "]";
    }

}
