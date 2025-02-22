package com.example.demo.modules.lessson.domain.usecases.class_schedule;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.ScheduleOverlapException;
import com.example.demo.modules.lessson.domain.usecases.lesson.GetLesson;

@Service
public class ScheduleSetUp {

    @Autowired
    private GetLesson getLesson;

    public List<Lesson> setUpSchedule(List<LessonId> requiredLessonsId,
            String startClasses, String endClasses) {

        Schedule schedule = new Schedule();
        List<Lesson> lessons = getLessonWithinTimeRange(startClasses, endClasses);
        
        List<Lesson> requiredLessons = getRequiredLessons(requiredLessonsId);
        requiredLessons.stream().forEach((lesson) -> {
            if (!schedule.add(lesson))
                throw new ScheduleOverlapException("Overlaps between lessons are not allowed");
        });

        setUp(lessons.toArray(Lesson[]::new), schedule);

        return schedule.getScheduledLessons();

    }

    private List<Lesson> getRequiredLessons(List<LessonId> requiredLessonsId) {
        if (requiredLessonsId == null)
            return new ArrayList<>();

        List<Lesson> requiredLessons = requiredLessonsId.stream()
                .map((id) -> getLesson.getOne(id))
                .collect(Collectors.toCollection(ArrayList::new));
        return requiredLessons;
    }

    private List<Lesson> getLessonWithinTimeRange(String start, String end) {
        if (start == null || end == null)
            throw new InvalidAttributeValueException(
                    "The time range for the classes must be provided");
        return getLesson.getAllLessonsWithinTimeRange(start, end);
    }

    private void setUp(Lesson[] lessons, Schedule schedule) {
        Arrays.sort(lessons, Comparator.comparing((lesson) -> lesson.getWeeklyClasses()));
        for (Lesson lesson : lessons) {
            schedule.add(lesson);
        }

    }

}
