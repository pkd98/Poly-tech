package com.pkd.member;

import java.util.Date;
import java.util.Objects;

public class Member {
    private String name;
    private Date signUpDay;
    private String address;
    private String phoneNumber;
    private Date birthDay;

    public Member(String name, Date signUpDay, String address, String phoneNumber, Date birthDay) {
        super();
        this.name = name;
        this.signUpDay = signUpDay;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.birthDay = birthDay;
    }

    public Member() {}

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
        return Objects.hash(address, birthDay, name, phoneNumber, signUpDay);
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
                && Objects.equals(name, other.name)
                && Objects.equals(phoneNumber, other.phoneNumber)
                && Objects.equals(signUpDay, other.signUpDay);
    }

    @Override
    public String toString() {
        return "Member [name=" + name + ", signUpDay=" + signUpDay + ", address=" + address
                + ", phoneNumber=" + phoneNumber + ", birthDay=" + birthDay + "]";
    }

}
