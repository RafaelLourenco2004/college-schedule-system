package com.example.demo.modules.lessson.domain.entities;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor
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

    // @JoinColumn(name = "lesson_date_id", insertable = false, updatable = false)
    @OneToMany(cascade = CascadeType.REMOVE)
    @JoinColumns({@JoinColumn(name = "subject_id"), @JoinColumn(name = "classroom_id")})
    private List<LessonDate> dates;

    // @ManyToOne(cascade = {CascadeType.REMOVE, CascadeType.PERSIST})
    // @JoinColumn(name = "lesson_date_id", insertable = false, updatable = false)
    // private LessonDate date;

    public Lesson(Subject subject, Classroom classroom) {
        this.subject = subject;
        this.classroom = classroom;
        id = new LessonId(subject.getId(), classroom.getId());
    }

    public void setDates(List<LessonDate> dates){
        this.dates = dates;
    }

    // public Lesson(Subject subject, Classroom classroom, LessonDate date) {
    //     this.subject = subject;
    //     this.classroom = classroom;
    //     this.date = date;
    //     id = new LessonId(subject.getId(), classroom.getId());
    // }

}
