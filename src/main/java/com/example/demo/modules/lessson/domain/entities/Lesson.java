package com.example.demo.modules.lessson.domain.entities;

import jakarta.persistence.CascadeType;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "lesson", schema = "lesson", catalog = "lesson")
public class Lesson {

    @EmbeddedId
    private LessonId id;

    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "subject_id", insertable = false, updatable = false)
    private Subject subject;

    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "classroom_id", insertable = false, updatable = false)
    private Classroom classroom;

    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "lesson_date_id", insertable = false, updatable = false)
    private LessonDate date;

    public Lesson(Subject subject, Classroom classroom, LessonDate date) {
        this.subject = subject;
        this.classroom = classroom;
        this.date = date;
        id = new LessonId(subject.getId(), classroom.getId(), date.getId());
    }

}
