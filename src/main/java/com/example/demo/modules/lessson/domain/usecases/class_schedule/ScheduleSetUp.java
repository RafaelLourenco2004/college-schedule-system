package com.example.demo.modules.lessson.domain.usecases.class_schedule;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.usecases.lesson.GetLesson;

@Service
public class ScheduleSetUp {

    @Autowired
    private GetLesson lessonGetService;

    private Schedule schedule;

    public List<Lesson> setSchedule(List<LessonId> requiredLessonsId,
            String startClasses, String endClasses) {

        schedule = new Schedule(startClasses, endClasses);

        List<Lesson> requiredLessons = requiredLessonsId.stream().map(
                (id) -> lessonGetService.getOne(id))
                .collect(Collectors.toCollection(ArrayList::new));
        requiredLessons.stream().forEach((lesson) -> schedule.scheduleLesson(lesson));

        List<Lesson> lessons = lessonGetService.getAll();
        Collections.sort(lessons, Comparator.comparingInt(Lesson::getWeeklyClasses));

        for (Lesson lesson : lessons) {
            try {
                schedule.scheduleLesson(lesson);
            } catch (EntityAlreadyExistsException e) {
                continue;
            } catch (Exception e) {
                throw new InvalidAttributeValueException("Something went wrong!");
            }
        }
        List<Lesson> scheduledLessons = schedule.getLessons();
        return scheduledLessons;
    }

    // public List<Lesson> setSchedule(List<Lesson> lessons, String startClasses, String endClasses) {
    //     schedule = new Schedule(startClasses, endClasses);

    //     List<Lesson> requiredLessons = lessons.stream()
    //             .map((id) -> lessonGetService.getOne(id))
    //             .collect(Collectors.toCollection(ArrayList::new));

    // }

    // private int set(List<Lesson> lessons, int j, int max) throws InvalidAttributeValueException {
    //     if (j == lessons.size())
    //         return max;

    //     int maxScheduleLessons = max;
    //     int temp = 0;
    //     for (int i = j; i < lessons.size(); i++) {
    //         try {
    //             schedule.scheduleLesson(lessons.get(i));
    //             temp = set(lessons, j + 1, max + 1);
    //             maxScheduleLessons = temp > maxScheduleLessons ? temp : maxScheduleLessons;
    //             schedule.unscheduleLesson(lessons.get(i));
    //         } catch (EntityAlreadyExistsException e) {
    //             continue;
    //         }
    //     }
    //     return maxScheduleLessons;
    // }
}
