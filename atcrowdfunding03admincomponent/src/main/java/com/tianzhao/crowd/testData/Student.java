package com.tianzhao.crowd.testData;

import java.util.List;
import java.util.Map;

public class Student {
    private Integer stuId;
    private String stuName;
    private Address address;
    private Map<String ,String> map;
    private List<Subject> subjectList;

    public Student(Integer stuId, String stuName, Address address, Map<String, String> map, List<Subject> subjectList) {
        this.stuId = stuId;
        this.stuName = stuName;
        this.address = address;
        this.map = map;
        this.subjectList = subjectList;
    }

    @Override
    public String toString() {
        return "Student{" +
                "stuId=" + stuId +
                ", stuName='" + stuName + '\'' +
                ", address=" + address +
                ", map=" + map +
                ", subjectList=" + subjectList +
                '}';
    }

    public Integer getStuId() {
        return stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Map<String, String> getMap() {
        return map;
    }

    public void setMap(Map<String, String> map) {
        this.map = map;
    }

    public List<Subject> getSubjectList() {
        return subjectList;
    }

    public void setSubjectList(List<Subject> subjectList) {
        this.subjectList = subjectList;
    }

    public Student() {
    }
}

