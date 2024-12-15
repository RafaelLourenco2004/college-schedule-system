package com.example.demo.modules.lessson.domain.entities;

public enum Weekday {

    MONDAY("monday"),
    TUESDAY("tuesday"),
    WEDNESDAY("wednesday"),
    THURSDAY("thursday"),
    FRIDAY("friday"),
    SATURDAY("saturday"),
    SUNDAY("sunday");

    private final String weekDay;

    private Weekday(String weekDay) {
        this.weekDay = weekDay;
    }

    public String getWeekDay() {
        return weekDay;
    }

    public static Weekday toWeekDay(String day) {
        for (Weekday weekday : Weekday.values()) {
            if (weekday.getWeekDay().equals(day))
                return weekday;
        }
        return null;
    }
}
