package com.pkd;

/*
 *  공사장과 그늘 간 - 점과 점사이의 거리 비교 처리
 */

public class DistanceBetweenPoints implements EvaluationWay {
    private Location comparison;
    private Location control;

    public DistanceBetweenPoints(Location comparison, Location control) {
        this.comparison = comparison;
        this.control = control;
    }

    @Override
    public boolean calculate() {
        boolean answer = false;
        ConstructionLocation newComparison = (ConstructionLocation) this.comparison;
        ShadeLocation newControl = (ShadeLocation) this.control;
        int comparisonX = newComparison.getX();
        int comparisonY = newComparison.getY();
        int comparisonR = newComparison.getMagnitudeOfNoise();
        int controlX = newControl.getX();
        int controlY = newControl.getY();

        if (Math.pow((controlX - comparisonX), 2) + Math.pow((controlY - comparisonY), 2) >= Math
                .pow(comparisonR, 2)) {
            answer = true;
        } else {
            answer = false;
        }
        return answer;
    }
}
