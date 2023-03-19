package com.pkd;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/*
 * 공사 현장과 그늘의 객체 인스턴스를 대신 생성하는 LocationBuilder 클래스이다.
 */

public class LocationBuilder {

    public LocationBuilder() {}

    // x 좌표, y좌표, Radius를 리스트 타입으로 받아 공사장위치 객체를 리턴함.
    public Location constructionBuild(List<Integer> constructionList) {
        return new ConstructionLocation(constructionList.get(0), constructionList.get(1),
                constructionList.get(2));
    }

    // 그늘 개수와 Scanner를 받아 입력값 처리 후 그늘 인스턴스들이 담긴 List를 리턴함.
    public List<Location> shadeBuild(int number, Scanner sc) {
        List<Location> instances = new ArrayList<Location>();
        for (int i = 0; i < number; i++) {
            int x = sc.nextInt();
            int y = sc.nextInt();
            instances.add(new ShadeLocation(x, y));
        }
        return instances;
    }

}
