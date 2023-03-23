package com.pkd.book;

import java.util.Date;
import java.util.Objects;
import com.pkd.utils.Utils;

public class Book {
    private int bookId; // 북 아이디 -> ArryList의 index로 대체
    private String name; // 책 이름
    private Date releaseDate; // 출간일
    private boolean rentState; // 반납 여부

    public static int autoIncreaseBookId = 0;

    public Book(String name, Date releaseDate) {
        super();
        this.name = name;
        this.bookId = autoIncreaseBookId++;
        this.releaseDate = releaseDate;
        this.rentState = false;
    }

    Book() {

    }
    public boolean getRentState() {
        return rentState;
    }
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public boolean isRentState() {
        return rentState;
    }

    public void setRentState(boolean rentState) {
        this.rentState = rentState;
    }

    public static int getAutoIncreaseId() {
        return autoIncreaseBookId;
    }

    public static void setAutoIncreaseId(int autoIncreaseId) {
        Book.autoIncreaseBookId = autoIncreaseId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(bookId, name, releaseDate);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Book other = (Book) obj;
        return bookId == other.bookId && Objects.equals(name, other.name)
                && Objects.equals(releaseDate, other.releaseDate);
    }

    @Override
    public String toString() {
        String convertReleaseDate = Utils.dateToString(releaseDate);
        return "ID : " + bookId + ", " + "도서명 : " + name + ", " + "출간일 : " + convertReleaseDate
                + ", " + "상태 : " + ((rentState == true) ? "대출 불가능" : "대출 가능");
    }
}
