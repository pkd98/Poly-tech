package com.pkd.mode;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import com.pkd.book.Book;
import com.pkd.book.BookUtil;
import com.pkd.member.Member;
import com.pkd.member.MemberUtil;
import com.pkd.rent.Rent;
import com.pkd.rent.RentUtil;

// 파일 입출력 기능을 메서드로 제공
public class SaveUtil {

    public static void bookToCsv() {
        if (SaveManager.saveMode == SaveMode.NO_SAVE) {
            return;
        } else {
            try {
                FileWriter writer = new FileWriter("book.csv");

                // CSV 파일의 헤더 작성
                writer.append("bookId,name,releaseDate,rentState\n");

                // Iterator를 사용하여 ArrayList의 객체들을 CSV 파일에 작성
                Iterator<Book> iterator = BookUtil.bookList.iterator();

                while (iterator.hasNext()) {
                    Book book = iterator.next();
                    writer.append(String.valueOf(book.getBookId())).append(",")
                            .append(book.getName()).append(",")
                            .append(String.valueOf(book.getReleaseDate())).append(",")
                            .append(String.valueOf(book.getRentState())).append("\n");
                }

                writer.close();
                System.out.println("CSV 파일이 성공적으로 작성되었습니다.");
            } catch (IOException e) {
                System.out.println("CSV 파일 작성 중 오류가 발생하였습니다.");
                e.printStackTrace();
            }
        }
    }

    public static void memberToCsv() {
        if (SaveManager.saveMode == SaveMode.NO_SAVE) {
            return;
        } else {
            try {
                FileWriter writer = new FileWriter("member.csv");

                // CSV 파일의 헤더 작성
                writer.append("id,name,signUpDay,address,phoneNumber,birthDay\n");

                // Iterator를 사용하여 ArrayList의 객체들을 CSV 파일에 작성
                Iterator<Member> iterator = MemberUtil.memberList.iterator();

                while (iterator.hasNext()) {
                    Member member = iterator.next();
                    writer.append(member.getId()).append(",").append(member.getName()).append(",")
                            .append(String.valueOf(member.getSignUpDay()))
                            .append(member.getAddress()).append(",").append(member.getPhoneNumber())
                            .append(",").append(String.valueOf(member.getBirthDay())).append(",")
                            .append("\n");
                }

                writer.close();
                System.out.println("CSV 파일이 성공적으로 작성되었습니다.");
            } catch (IOException e) {
                System.out.println("CSV 파일 작성 중 오류가 발생하였습니다.");
                e.printStackTrace();
            }
        }
    }

    public static void rentToCsv() {
        if (SaveManager.saveMode == SaveMode.NO_SAVE) {
            return;
        } else {
            try {
                FileWriter writer = new FileWriter("rent.csv");

                // CSV 파일의 헤더 작성
                writer.append("rentId,memberId,bookId,rentExtentionState,returnDate\n");

                // Iterator를 사용하여 ArrayList의 객체들을 CSV 파일에 작성
                Iterator<Rent> iterator = RentUtil.rentList.iterator();

                while (iterator.hasNext()) {
                    Rent rent = iterator.next();
                    writer.append(String.valueOf(rent.getRentId())).append(",")
                            .append(rent.getMemberId()).append(",")
                            .append(String.valueOf(rent.getBookId())).append(",")
                            .append(String.valueOf(rent.isRentExtentionState())).append(",")
                            .append(String.valueOf(rent.getReturnDate())).append("\n");
                }

                writer.close();
                System.out.println("CSV 파일이 성공적으로 작성되었습니다.");
            } catch (IOException e) {
                System.out.println("CSV 파일 작성 중 오류가 발생하였습니다.");
                e.printStackTrace();
            }
        }
    }



}
