package com.example.demo.modules.lessson.domain.entities;

public enum Semester {
    FIRST("1"),
    SECOND("2"),
    THIRD("3"),
    FORTH("4"),
    FIFTH("5"),
    SIXTH("6"),
    SEVENTH("7"),
    EIGHTH("8");

    private final String semester;

    private Semester(String semester) {
        this.semester = semester;
    }

    public String getSemester() {
        return semester;
    }

}
