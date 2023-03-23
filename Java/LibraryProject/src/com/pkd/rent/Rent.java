package com.pkd.rent;

import java.util.Calendar;
import java.util.Date;
import java.util.Objects;
import com.pkd.utils.Utils;

public class Rent {
    private int rentId;
    private String memberId;
    private int bookId;
    private boolean rentExtentionState; // 반납 연장 상태
    private Date returnDate; // 반납일

    public static int autoIncreaseRentId = 0;


    public Rent(String memberId, int bookId) {
        this.rentId = autoIncreaseRentId++;
        this.memberId = memberId;
        this.bookId = bookId;

        Date now = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        calendar.add(Calendar.DATE, 14);
        this.returnDate = calendar.getTime();
    }

    public int getRentId() {
        return rentId;
    }

    public void setRentId(int rendId) {
        this.rentId = rendId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public boolean isRentExtentionState() {
        return rentExtentionState;
    }

    public void setRentExtentionState(boolean rentExtentionState) {
        this.rentExtentionState = rentExtentionState;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    @Override
    public int hashCode() {
        return Objects.hash(bookId, memberId, rentId, rentExtentionState, returnDate);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Rent other = (Rent) obj;
        return bookId == other.bookId && Objects.equals(memberId, other.memberId)
                && rentId == other.rentId && rentExtentionState == other.rentExtentionState
                && Objects.equals(returnDate, other.returnDate);
    }

    @Override
    public String toString() {
        String convertReturnDate = Utils.dateToString(returnDate);
        return "Rent ID : " + rentId + ", 회원 ID : " + memberId + ", 책 ID : " + bookId + ", 연장 상태 : "
                + ((rentExtentionState == false) ? "연장 가능" : "연장 불가능") + ", 반납일 : " + convertReturnDate;
    }
}
