package com.pkd.mode;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import com.pkd.book.Book;
import com.pkd.book.BookUtil;
import com.pkd.member.Member;
import com.pkd.member.MemberUtil;
import com.pkd.rent.Rent;
import com.pkd.rent.RentUtil;

// 파일 입출력 기능을 메서드로 제공
public class SaveUtil {

    public static void csvToBook() {
        if (SaveManager.saveMode == SaveMode.NO_SAVE) {
            return;
        } else {
            String csvFile = "book.csv";
            String line = "";
            String csvSplitBy = ",";

            try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

                // 첫 번째 라인은 필드명이므로 읽어서 처리하지 않음
                br.readLine();

                while ((line = br.readLine()) != null) {
                    String[] data = line.split(csvSplitBy);

                    int bookId = Integer.parseInt(data[0]);
                    String name = data[1];
                    String releaseDate = data[2];
                    boolean rentState = Boolean.parseBoolean(data[3]);


                    // SimpleDateFormat 객체 생성
                    SimpleDateFormat dateFormat =
                            new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
                    Date newReleaseDate = dateFormat.parse(releaseDate);

                    Book book = new Book(bookId, name, newReleaseDate, rentState);
                    BookUtil.bookList.add(book);
                    Book.autoIncreaseBookId = bookId + 1;
                }

            } catch (IOException e) {
                e.printStackTrace();
            } catch (ParseException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    public static void csvToMember() {
        if (SaveManager.saveMode == SaveMode.NO_SAVE) {
            return;
        } else {
            String csvFile = "member.csv";
            String line = "";
            String csvSplitBy = ",";

            try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

                // 첫 번째 라인은 필드명이므로 읽어서 처리하지 않음
                br.readLine();

                while ((line = br.readLine()) != null) {
                    String[] data = line.split(csvSplitBy);

                    String id = data[0];
                    String name = data[1];
                    String signUpDay = data[2];
                    String address = data[3];
                    String phoneNumber = data[4];
                    String birthDay = data[5];

                    // SimpleDateFormat 객체 생성
                    SimpleDateFormat dateFormat =
                            new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
                    Date signUpDayDate = dateFormat.parse(signUpDay);
                    Date birthDayDate = dateFormat.parse(birthDay);

                    Member member =
                            new Member(id, name, signUpDayDate, address, phoneNumber, birthDayDate);
                    MemberUtil.memberList.add(member);
                }

            } catch (IOException e) {
                e.printStackTrace();
            } catch (ParseException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    public static void csvToRent() {
        if (SaveManager.saveMode == SaveMode.NO_SAVE) {
            return;
        } else {
            String csvFile = "rent.csv";
            String line = "";
            String csvSplitBy = ",";

            try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

                // 첫 번째 라인은 필드명이므로 읽어서 처리하지 않음
                br.readLine();

                while ((line = br.readLine()) != null) {
                    String[] data = line.split(csvSplitBy);

                    int rentId = Integer.parseInt(data[0]);
                    String memberId = data[1];
                    int bookId = Integer.parseInt(data[2]);
                    boolean rentExtentionState = Boolean.getBoolean(data[3]);
                    String returnDate = data[4];

                    // SimpleDateFormat 객체 생성
                    SimpleDateFormat dateFormat =
                            new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
                    Date newReturnDate = dateFormat.parse(returnDate);

                    Rent rent =
                            new Rent(rentId, memberId, bookId, rentExtentionState, newReturnDate);
                    RentUtil.rentList.add(rent);
                    Rent.autoIncreaseRentId = rentId + 1;
                }

            } catch (IOException e) {
                e.printStackTrace();
            } catch (ParseException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

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
                            .append(String.valueOf(member.getSignUpDay())).append(",")
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
