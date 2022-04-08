package com.tianzhao.crowd.testData;

public class Address {
    private String city;
    private String provicnce;
    private String street;

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvicnce() {
        return provicnce;
    }

    @Override
    public String toString() {
        return "Address{" +
                "city='" + city + '\'' +
                ", provicnce='" + provicnce + '\'' +
                ", street='" + street + '\'' +
                '}';
    }

    public void setProvicnce(String provicnce) {
        this.provicnce = provicnce;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public Address(String city, String provicnce, String street) {
        this.city = city;
        this.provicnce = provicnce;
        this.street = street;
    }

    public Address() {
    }
}
