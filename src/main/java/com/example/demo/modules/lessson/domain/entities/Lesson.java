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

    @ManyToOne()
    @JoinColumn(name = "subject_id", insertable = false, updatable = false)
    private Subject subject;

    @ManyToOne()
    @JoinColumn(name = "classroom_id", insertable = false, updatable = false)
    private Classroom classroom;

    // @OneToMany(cascade = CascadeType.REMOVE, orphanRemoval = true)
    @OneToMany()
    @JoinColumns({ @JoinColumn(name = "subject_id", referencedColumnName = "subject_id"),
            @JoinColumn(name = "classroom_id", referencedColumnName = "classroom_id") })
    private List<LessonDate> dates;

    public Lesson(Subject subject, Classroom classroom) {
        this.subject = subject;
        this.classroom = classroom;
        id = new LessonId(subject.getId(), classroom.getId());
    }

    public void setDates(List<LessonDate> dates) {
        this.dates = dates;
    }

    public int getWeeklyClasses() {
        return dates.size();
    }

}
