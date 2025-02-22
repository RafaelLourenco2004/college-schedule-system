package com.example.demo.modules.lessson.domain.usecases.class_schedule;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.Subject;

public class Schedule {

    private List<Lesson> scheduledLessons;

    private List<Subject> subjects;

    public Schedule() {
        this.scheduledLessons = new ArrayList<>();
        this.subjects = new ArrayList<>();
    }

    public boolean add(Lesson lesson) {
        if (!containsSubject(lesson.getSubject()) && !isThereOverlap(scheduledLessons, lesson)) {
            scheduledLessons.add(lesson);
            subjects.add(lesson.getSubject());
            return true;
        }
        return false;
    }

    private boolean containsSubject(Subject subject) {
        return subjects.contains(subject);
    }

    private boolean isThereOverlap(Collection<Lesson> scheduledLessons, Lesson lesson) {
        for (Lesson scheduledLesson : scheduledLessons) {
            if (scheduledLesson.isThereOverlap(lesson))
                return true;
        }
        return false;
    }

    public List<Lesson> getScheduledLessons() {
        return scheduledLessons;
    }

}
