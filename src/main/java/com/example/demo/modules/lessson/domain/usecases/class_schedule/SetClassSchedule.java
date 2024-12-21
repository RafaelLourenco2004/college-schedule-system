package com.example.demo.modules.lessson.domain.usecases.class_schedule;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.LessonTime;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.entities.Weekday;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

@Service
public class SetClassSchedule {

    private Map<Weekday, Map<LocalTime, Lesson>> schedule;

    public List<Lesson> setClassSchedule(List<Lesson> requiredLessons, Student student,
            LessonTime startClasses, LessonTime endClasses) {
        
        initializeSchedule(startClasses, endClasses);
        requiredLessons.stream().forEach((lesson) -> setLesson(lesson));

        return null;
    }

    private void setLesson(Lesson lesson) {
        List<LessonDate> lessonDates = lesson.getDates();

        Map<LocalTime, Lesson> scheduleSlot;
        for (LessonDate lessonDate : lessonDates) {
            scheduleSlot = schedule.get(lessonDate.getWeekDay());
            if (scheduleSlot.containsKey(lessonDate.getStartTime()))
                if (scheduleSlot.get(lessonDate.getStartTime()) != null)
                    scheduleSlot.put(lessonDate.getStartTime(), lesson);
                else
                    throw new EntityAlreadyExistsException(
                        String.format("The schedule slot %s - %s is already filled",
                            lessonDate.getWeekDay().getWeekDay(), lessonDate.getStartTime().toString()));
            else {
                throw new InvalidAttributeValueException(
                        String.format("The lesson %s is not within the specified time range.",
                                lesson.getId().toString()));
            }
        }
    }

    private void initializeSchedule(LessonTime startClasses, LessonTime endClasses) {
        schedule = new HashMap<>();

        Map<LocalTime, Lesson> scheduleSlot = new HashMap<>();
        for (Weekday weekday : Weekday.values()) {
            for (LessonTime lessonTime : LessonTime.values()) {
                if (isWithinTimeRange(startClasses, endClasses, lessonTime)) {
                    scheduleSlot.put(LocalTime.parse(lessonTime.getTime()), null);
                    schedule.put(weekday, null);
                }
            }
        }
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
}
