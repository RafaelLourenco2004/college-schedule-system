package com.example.demo.modules.lessson.domain.entities;

import java.util.Collection;
import java.util.List;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
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

    @OneToMany()
    @JoinColumns({ @JoinColumn(name = "subject_id", referencedColumnName = "subject_id"),
            @JoinColumn(name = "classroom_id", referencedColumnName = "classroom_id") })
    private List<LessonDate> dates;

    @ManyToMany()
    @JoinTable(name = "student_subject_enrollment", schema = "lesson", joinColumns = {
            @JoinColumn(name = "subject_id", referencedColumnName = "subject_id"),
            @JoinColumn(name = "classroom_id", referencedColumnName = "classroom_id")
    }, inverseJoinColumns = @JoinColumn(name = "student_id"))
    private Collection<Student> enrolledStudents;

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

    public void addStudent(Student student) {
        enrolledStudents.add(student);
    }

}
