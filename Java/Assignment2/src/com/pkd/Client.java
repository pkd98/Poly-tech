package com.pkd;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

// 조용한 곳을 찾으려는 나 - Client(main) 클래스
public class Client {

    // 공사장 탐색
    public List<Integer> constructionMeasure(Scanner sc) {
        List<Integer> constructionMeasurementValues = new ArrayList<Integer>();

        constructionMeasurementValues.add(sc.nextInt()); // construction X 좌표
        constructionMeasurementValues.add(sc.nextInt()); // construction Y 좌표
        constructionMeasurementValues.add(sc.nextInt()); // noiseRadius 공사 소음 반경

        return constructionMeasurementValues;
    }

    // 그늘 개수 세기
    public int shadeNumberCount(Scanner sc) {
        int shadeNumber = sc.nextInt();
        return shadeNumber;
    }

}
