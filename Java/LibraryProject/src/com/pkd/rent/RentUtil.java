package com.pkd.rent;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import com.pkd.book.BookUtil;

public class RentUtil {
    public static List<Rent> rentList = new ArrayList<>();

    public static void bookRent(int bookIdInput, String memberIdInput) { // 도서 대출
        // 대출 정보 클래스
        Rent rent = new Rent(memberIdInput, bookIdInput);
        rentList.add(rent);
        rentSort(rentList);
    }

    public static void bookReturn(Rent rent) { // 도서 반납
        // 해당 도서 대출 상대 false
        for (com.pkd.book.Book book : BookUtil.bookList) {
            if (book.getBookId() == rent.getBookId()) {
                book.setRentState(false);
            }
        }
        rentList.remove(rent); // 도서 반납 완료
        rentSort(rentList);

    }

    public static void extend(Rent rent) { // 대출 연장
        if (rent.isRentExtentionState() == true) {
            System.out.println("연장은 한번만 가능");
            return;
        } else {
            Date date = rent.getReturnDate();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.DATE, 7);
            rent.setReturnDate(calendar.getTime());
            System.out.println("정상적으로 대출 연장되셨습니다.");
        }
    }

    public static void selectRent() {
        System.out.println("======== 도서 대출 목록 ========");
        for (Rent rent : rentList) {
            System.out.println(rent.toString());
        }
        System.out.println("===============================");
    }

    public static void rentSort(List<Rent> list) { // 반납일 기준으로 오름차순
        list.sort(new Comparator<Rent>() {
            @Override
            public int compare(Rent o1, Rent o2) {
                return o1.getReturnDate().compareTo(o2.getReturnDate());
            }
        });
    }

}
