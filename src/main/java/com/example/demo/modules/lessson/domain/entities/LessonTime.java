package com.example.demo.modules.lessson.domain.entities;

public enum LessonTime {

    LESSON_07_30("07:30"),
    LESSON_08_20("08:20"),
    LESSON_09_10("09:10"),
    LESSON_09_20("09:20"),
    LESSON_10_10("10:10"),
    LESSON_11_00("11:00"),
    LESSON_11_50("11:50"),
    LESSON_12_40("12:40"),
    LESSON_13_30("13:30"),
    LESSON_14_20("14:20"),
    LESSON_15_10("15:10"),
    LESSON_16_00("16:00"),
    LESSON_16_50("16:50"),
    LESSON_17_40("17:40"),
    LESSON_18_30("18:30"),
    LESSON_19_20("19:20"),
    LESSON_20_10("20:10"),
    LESSON_21_00("21:00"),
    LESSON_21_10("21:10"),
    LESSON_22_45("22:45");

    private final String time;

    private LessonTime(String time) {
        this.time = time;
    }

    public String getTime() {
        return time;
    }

    public static LessonTime toLessonTime(String time) {
        for (LessonTime lessonTime : LessonTime.values()) {
            if (time.equals(lessonTime.getTime()))
                return lessonTime;
        }
        return null;
    }
}
