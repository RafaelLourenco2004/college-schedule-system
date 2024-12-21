package com.example.demo.modules.lessson.domain.entities;

public enum LessonTime {

    LESSON_07_00("07:00"),
    LESSON_07_45("07:45"),
    LESSON_08_30("08:30"),
    LESSON_09_15("09:15"),
    LESSON_10_00("10:00"),
    LESSON_10_45("10:45"),
    LESSON_11_30("11:30"),
    LESSON_12_15("12:15"),
    LESSON_13_00("13:00"),
    LESSON_13_45("13:45"),
    LESSON_14_30("14:30"),
    LESSON_15_15("15:15"),
    LESSON_16_00("16:00"),
    LESSON_16_45("16:45"),
    LESSON_17_30("17:30"),
    LESSON_18_15("18:15"),
    LESSON_19_00("19:00"),
    LESSON_19_45("19:45"),
    LESSON_20_30("20:30"),
    LESSON_21_15("21:15"),
    LESSON_22_00("22:00"),
    LESSON_22_45("22:45");
    
    // private static final int 
    
    private final String time;

    private LessonTime(String time) {
        this.time = time;
    }

    public String getTime() {
        return time;
    }
}
