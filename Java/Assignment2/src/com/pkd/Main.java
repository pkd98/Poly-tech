package com.pkd;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        List<Integer> constructionInformations = new ArrayList<Integer>(); // 처음 공사장 정보 Input 값 저장용
        int shadeNumber = 0; // 그늘 개수 저장 변수

        /*
         * 1. '나'는 공사장을 탐색, 그 측정 결과로 LocationBuilder를 통해 공사장 인스턴스 생성
         */

        // 1-1 '나' 객체 인스턴스를 생성
        Client I = new Client();
        // 1-2 공사장 측정
        constructionInformations = I.constructionMeasure(scanner);
        // 1-3 location 인스턴스 생성을 위임받아 생성하는 locationBuilder를 생성.
        LocationBuilder locationBuilder = new LocationBuilder();
        // 1-4 공사장 인스턴스 생성
        Location constructionLocation = locationBuilder.constructionBuild(constructionInformations);


        /*
         * 2. '나'는 그늘 개수 만큼 그늘 위치를 탐색, LocationBuilder를 통해 그늘 인스턴스 생성
         */

        // 2-1 그늘 수 세기
        shadeNumber = I.shadeNumberCount(scanner);
        // 2-2 그늘 수 만큼 그늘 인스턴스 생성
        List<Location> shadeLocation = locationBuilder.shadeBuild(shadeNumber, scanner);

        /*
         * 3. 각 그늘에 대한 소음 판단
         */

        Noise noise = new Noise(); // 소음 인스턴스 생성

        // 그늘 개수 만큼 소음 판단 반복
        for (int i = 0; i < shadeNumber; i++) {
            // 3-1 소음 판단하는 방식 인스턴스 생성 (점과 점사이의 거리 비교)
            EvaluationWay way =
                    new DistanceBetweenPoints(constructionLocation, shadeLocation.get(i));
            // 3-2 소음평가 인스턴스 생성 - (소음, 평가 방식) parameter
            Evaluation noiseEvaluation = new NoiseEvaluation(noise, way);
            // 3-3 최종적으로 소음을 판단
            System.out.println(noiseEvaluation.evaluate());
        }
    }
}
