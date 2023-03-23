package reference3;

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class BookList extends Books implements Book {

    static List<List<String>> booklist = new ArrayList<>(); // 도서 목록
    private int version = 1; // 책 버젼( ex) 해리포터1, 해리포터2 ... )
    private int pcnt; // 대여 가능 도서 개수

    Scanner sc = new Scanner(System.in);

    public void bookshow() {
        System.out.println("------ 도서관리 프로그램입니다. ------");
        System.out.println(" 1. 도서 등록");
        System.out.println(" 2. 총 도서 목록 보기");
        System.out.println(" 3. 현재 대여 가능 도서 목록 보기");
        System.out.println(" 4. 현재 대여 중인 도서 목록 보기");
        System.out.println(" 5. 종료");
        System.out.println("-------------------------------");



        while (true) {
            System.out.print("\n 무엇을 하시겠습니까? : ");
            int type = Integer.parseInt(sc.nextLine());
            if (type == 1) {
                register();
            } else if (type == 2) {
                blist();
            } else if (type == 3) {
                rentPossible();
            } else if (type == 4) {
                rentImpossible();
            } else if (type == 5) {
                System.out.println(" 프로그램을 종료합니다.");
                break;
            } else {
                System.out.println(" 잘못된 입력입니다 다시 입력하세요.");
            }
        }
    }


    // 도서 빌리기
    @Override
    public void rent() {
        int num; // 대여하고 싶은 도서 번호
        System.out.println("---- 현재 대여 가능 도서 목록입니다. ----");
        pcnt = 0;
        for (int i = 0; i < booklist.size(); i++) {
            if (booklist.get(i).get(4).equals("대여 가능")) {
                System.out.printf("%d번 책 제목 : %s, 책 번호 : %s %s \n", ++pcnt, booklist.get(i).get(0),
                        booklist.get(i).get(3), booklist.get(i).get(4));
            }
        }
        System.out.print(" 대여하고 싶은 도서의 번호를 고르세요. : ");
        num = Integer.parseInt(sc.nextLine());
        pcnt = 0;
        for (int i = 0; i < booklist.size(); i++) {
            if (booklist.get(i).get(4).equals("대여 가능")) {
                ++pcnt;
                if (num == pcnt) {
                    System.out.printf("\n %s (%s) 를 대여합니다. \n", booklist.get(i).get(0),
                            booklist.get(i).get(3));
                    Libraryview.rentmember.add(booklist.get(i).get(0));
                    Libraryview.rentmember.add(booklist.get(i).get(3));
                    booklist.get(i).remove(4);
                    booklist.get(i).add("현재 대여 중");

                }
            }
        }
    }

    // 도서 반납하기
    // @Override
    // public void reTurn() {
    // for(int i = 0; i < Libraryview.rentmemberlist.size(); i++) {
    // Libraryview.rentmemberlist.get(i).get(0);
    // }
    // }

    // 새로운 도서 등록
    @Override
    public void register() {
        Books book = new Books("덕재의 도서관리 비법" + version, "최덕재", "참고서", "10" + version++);
        List<String> newbook = new ArrayList<>();
        newbook.addAll(book.bookinfo());
        newbook.add("대여 가능");
        booklist.add(newbook);
        System.out.printf(" 도서등록이 완료되었습니다. (책 제목 : %s)\n", newbook.get(0));
    }

    // 등록된 도서 리스트 출력 => 책 정보와 대여 가능여부 출력
    @Override
    // 도서 목록을 txt파일로 저장
    public void blist() {
        System.out.println("------ 2. 현재 대여 중인 도서 목록 ------");

        FileOutputStream fos = null;
        DataOutputStream dos = null;


        try {
            fos = new FileOutputStream("project01/booklist.txt");
            dos = new DataOutputStream(fos);

            for (int i = 0; i < booklist.size(); i++) {
                System.out.printf("책 제목 : %s, 책 저자 : %s, 책 종류 : %s, 책 번호 : %s, %s \n",
                        booklist.get(i).get(0), booklist.get(i).get(1), booklist.get(i).get(2),
                        booklist.get(i).get(3), booklist.get(i).get(4));

                dos.writeUTF(booklist.get(i).get(0) + " / " + booklist.get(i).get(1) + " / "
                        + booklist.get(i).get(2) + " / " + booklist.get(i).get(3) + " / "
                        + booklist.get(i).get(4) + "\n");
            }

            dos.flush();
            System.out.println(" * booklist에 저장 완료....");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            FileClose.close(dos, fos);
        }

        System.out.printf(" * 총 도서는 %d권 입니다.\n", booklist.size());
    }

    // 전체 도서 중 대여 가능한 도서만 출력
    @Override
    public void rentPossible() {
        pcnt = 0;
        System.out.println("------ 3. 현재 대여 가능 도서 목록 ------");
        for (int i = 0; i < booklist.size(); i++) {
            if (booklist.get(i).get(4).equals("대여 가능")) {
                System.out.printf("책 제목 : %s, 책 번호 : %s %s \n", booklist.get(i).get(0),
                        booklist.get(i).get(3), booklist.get(i).get(4));
                pcnt++;
            }
        }
        System.out.printf(" * 대여 가능 도서는 %d권 입니다.\n", pcnt);
    }

    // 전체 도서 중 대여 불가능한 도서 출력
    @Override
    public void rentImpossible() {
        int ipcnt = 0;
        System.out.println("------ 4. 현재 대여 중인 도서 목록 ------");
        for (int i = 0; i < booklist.size(); i++) {
            if (booklist.get(i).get(4).equals("현재 대여 중")) {
                System.out.printf("책 제목 : %s, 책 번호 : %s %s \n", booklist.get(i).get(0),
                        booklist.get(i).get(3), booklist.get(i).get(4));
                ipcnt += 1;
            }
        }
        System.out.printf(" * 현재 대여 중인 도서는 %d권 입니다.\n", ipcnt);
    }

}
