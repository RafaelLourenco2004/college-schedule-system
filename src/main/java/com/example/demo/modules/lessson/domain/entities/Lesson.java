package com.example.demo.modules.lessson.domain.entities;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.modules.lessson.domain.interfaces.ILesson;
import com.example.demo.modules.lessson.domain.interfaces.ILessonDate;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;

@Getter
@Entity
@Table(name = "", catalog = "")
public class Lesson implements ILesson {

    @EmbeddedId
    private LessonId id;

    @ManyToOne()
    @JoinColumn(name = "subject_id", insertable = false, updatable = false)
    private Subject subject;

    @ManyToOne
    @JoinColumn(name = "classroom_id", insertable = false, updatable = false)
    private Classroom classroom;

    @ManyToMany()
    @JoinTable(
        joinColumns = @JoinColumn(name = "id"), 
        inverseJoinColumns = @JoinColumn(name = "lesson_date_id")
    )
    private List<LessonDate> dates;

    public List<ILessonDate> getDates() {
        List<ILessonDate> resDates = new ArrayList<>();
        dates.stream().forEach(date -> resDates.add(date));
        return resDates;

    }

}
