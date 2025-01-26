package com.example.demo.modules.lessson.domain.usecases.class_schedule;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Set;
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

        List<Lesson> requiredLessons = getRequiredLessons(requiredLessonsId);

        PriorityQueue<List<Lesson>> queue = new PriorityQueue<>(
                (list1, list2) -> Integer.compare(list2.size(), list1.size()));

        List<Lesson> lessons = getLessonWithinTimeRange(startClasses, endClasses);
        Set<Lesson> scheduledLessons = new HashSet<>();

        requiredLessons.stream().forEach((lesson) -> {
            if (isThereOverlap(scheduledLessons, lesson))
                throw new ScheduleOverlapException("Overlapping lessons are not permitted");
            scheduledLessons.add(lesson);
            lessons.remove(lesson);
        });

        setUp(queue, lessons, scheduledLessons, 0);

        return queue.peek();

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

    private void setUp(PriorityQueue<List<Lesson>> queue, List<Lesson> lessons,
            Set<Lesson> scheduledLessons, int i) {

        if (i == lessons.size()) {
            queue.add(new ArrayList<>(scheduledLessons));
            return;
        }

        setUp(queue, lessons, scheduledLessons, i + 1);
        if (!isThereOverlap(scheduledLessons, lessons.get(i))) {
            scheduledLessons.add(lessons.get(i));
            setUp(queue, lessons, scheduledLessons, i + 1);
            scheduledLessons.remove(lessons.get(i));
        }
    }

    private boolean isThereOverlap(Collection<Lesson> scheduledLessons, Lesson lesson) {
        for (Lesson scheduledLesson : scheduledLessons) {
            if (scheduledLesson.isThereOverlap(lesson))
                return true;
        }
        return false;
    }

}
