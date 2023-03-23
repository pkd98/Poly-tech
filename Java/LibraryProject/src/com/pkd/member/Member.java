package com.pkd.member;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import com.pkd.utils.Utils;

public class Member {
    private String id;
    private String name;
    private Date signUpDay;
    private String address;
    private String phoneNumber;
    private Date birthDay;

    public Member(String id, String name, Date signUpDay, String address, String phoneNumber,
            Date birthDay) {
        super();
        this.id = id;
        this.name = name;
        this.signUpDay = signUpDay;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.birthDay = birthDay;
    }

    public Member() {}


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getSignUpDay() {
        return signUpDay;
    }

    public void setSignUpDay(Date signUpDay) {
        this.signUpDay = signUpDay;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Date birthDay) {
        this.birthDay = birthDay;
    }

    @Override
    public int hashCode() {
        return Objects.hash(address, birthDay, id, name, phoneNumber, signUpDay);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Member other = (Member) obj;
        return Objects.equals(address, other.address) && Objects.equals(birthDay, other.birthDay)
                && Objects.equals(id, other.id) && Objects.equals(name, other.name)
                && Objects.equals(phoneNumber, other.phoneNumber)
                && Objects.equals(signUpDay, other.signUpDay);
    }

    @Override
    public String toString() {
        String convertSignUpDay = Utils.dateToString(signUpDay);
        String convertBirthday = Utils.dateToString(birthDay);
        SimpleDateFormat getYearFormat = new SimpleDateFormat("yyyy");
        Date now = new Date();
        int age = Integer.parseInt(getYearFormat.format(now))
                - Integer.parseInt(getYearFormat.format(birthDay)) + 1;

        return "id :  " + id + ", 이름 : " + name + ", 나이 : " + age + ", 생일 : " + convertBirthday
                + ", 가입일 : " + convertSignUpDay + ", 주소 : " + address + ", 연락처 : " + phoneNumber;
    }

}
