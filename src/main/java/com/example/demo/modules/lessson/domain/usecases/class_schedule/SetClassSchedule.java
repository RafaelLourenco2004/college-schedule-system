package com.example.demo.modules.lessson.domain.usecases.class_schedule;

import java.time.LocalTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.entities.LessonTime;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.entities.Weekday;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.usecases.lesson.LessonGetService;

@Service
public class SetClassSchedule {

    @Autowired
    private LessonGetService lessonGetService;

    private Map<Weekday, Map<LocalTime, Lesson>> schedule;

    public List<Lesson> setClassSchedule(List<LessonId> requiredLessonsId, Student student,
            String startClasses, String endClasses) {

        initializeSchedule(LessonTime.toLessonTime(startClasses), LessonTime.toLessonTime(endClasses));

        List<Lesson> requiredLessons = requiredLessonsId.stream().map(
                (id) -> lessonGetService.getOne(id)).toList();
        requiredLessons.stream().forEach((lesson) -> setLesson(lesson));

        Collections.sort(requiredLessons, (a, b) -> compareLessonPerWeeklyClasses(a, b));

        for (Lesson lesson : requiredLessons) {
            try {
                setLesson(lesson);
            } catch (EntityAlreadyExistsException e) {
                continue;
            } catch (Exception e) {
                throw new InvalidAttributeValueException("Something went wrong!");
            }
        }

        List<Lesson> scheduledLessons = schedule.values().stream()
                .flatMap((value) -> value.values().stream())
                .filter((lesson) -> lesson != null)
                .toList();

        return scheduledLessons;
    }

    private int compareLessonPerWeeklyClasses(Lesson a, Lesson b) {
        return b.getWeeklyClasses() - a.getWeeklyClasses();
    }

    private void initializeSchedule(LessonTime startClasses, LessonTime endClasses) {
        if (startClasses == null || endClasses == null)
            throw new InvalidAttributeValueException("The times provided is invalid.");

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
