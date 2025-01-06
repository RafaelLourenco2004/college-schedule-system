package com.example.demo.modules.lessson.domain.usecases.class_schedule;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.LessonTime;
import com.example.demo.modules.lessson.domain.entities.Weekday;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

public class Schedule {

    private Map<Weekday, Map<LocalTime, Lesson>> schedule;

    public Schedule(String startClasses, String endClasses) {
        schedule = getSchedule(LessonTime.toLessonTime(startClasses), LessonTime.toLessonTime(endClasses));
    }

    private Map<Weekday, Map<LocalTime, Lesson>> getSchedule(LessonTime startClasses, LessonTime endClasses) {
        if (startClasses == null || endClasses == null)
            throw new InvalidAttributeValueException("The times provided is invalid.");

        Map<Weekday, Map<LocalTime, Lesson>> newSchedule = new HashMap<>();

        Map<LocalTime, Lesson> scheduleSlot;
        for (Weekday weekday : Weekday.values()) {
            scheduleSlot = new HashMap<>();
            for (LessonTime lessonTime : LessonTime.values()) {
                if (isWithinTimeRange(startClasses, endClasses, lessonTime))
                    scheduleSlot.put(LocalTime.parse(lessonTime.getTime()), null);
            }
            newSchedule.put(weekday, scheduleSlot);
        }

        return newSchedule;
    }

    private boolean isWithinTimeRange(LessonTime startTime, LessonTime endTime, LessonTime time) {
        return !isEarlier(startTime, time) && !isLater(endTime, time);
    }

    private boolean isEarlier(LessonTime time1, LessonTime time2) {
        LocalTime localTime1 = LocalTime.parse(time1.getTime());
        LocalTime localTime2 = LocalTime.parse(time2.getTime());
        return localTime2.isBefore(localTime1);
    }

    private boolean isLater(LessonTime time1, LessonTime time2) {
        LocalTime localTime1 = LocalTime.parse(time1.getTime());
        LocalTime localTime2 = LocalTime.parse(time2.getTime());
        return localTime2.isAfter(localTime1);
    }

    public void setLesson(Lesson lesson) {
        List<LessonDate> lessonDates = lesson.getDates();

        Map<LocalTime, Lesson> scheduleSlot;
        for (LessonDate lessonDate : lessonDates) {
            scheduleSlot = schedule.get(lessonDate.getWeekDay());

            if (!scheduleSlot.containsKey(lessonDate.getStartTime()))
                throw new InvalidAttributeValueException(
                        String.format("The lesson %s is not within the specified time range.",
                                lesson.getId().toString()));

            if (scheduleSlot.get(lessonDate.getStartTime()) != null)
                throw new EntityAlreadyExistsException(
                        String.format("Conflict: The schedule slot %s - %s is already filled",
                                lessonDate.getWeekDay().getWeekDay(), lessonDate.getStartTime().toString()));

            scheduleSlot.put(lessonDate.getStartTime(), lesson);
        }
    }

    public List<Lesson> getLessons() {
        List<Lesson> scheduledLessons = schedule.values().stream()
                .flatMap((value) -> value.values().stream())
                .filter((lesson) -> lesson != null)
                .distinct()
                .toList();
        return scheduledLessons;
    }
}
